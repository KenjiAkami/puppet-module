<?php 


class MobileImageAddCopyFlag {

	private static $READ_BYTE			=4096;
/////////////////////////////////////////////////////////////////////////////////////////////////////////
//PNG

	private static $PNG_SIGNATURE				= "\x89\x50\x4e\x47\x0d\xa\x1a\x0a";
	private static $PNG_SIGNATURE_LEN			= 8;
	private static $PNG_IHDR_LEN					= 25;

	private static $PNG_COPYRIGHT_BIN			="\x00\x00\x00\x25tEXtCopyright\0kddi_copyright=on,copy=\"NO\"\xD0\xC5\x26\x10";


	/**
	 * PNGシグネチャチェック
	 * @author   stanaka
	 * @since    2011/06/02
	 *
	 * @param $fnR
	 * @return unknown_type
	 */
	private static function PNGCheckSignature($fnR){

		if (self::$PNG_SIGNATURE === fread($fnR,self::$PNG_SIGNATURE_LEN)){
			return self::$PNG_SIGNATURE;
		}
		return false;
	}
/////////////////////////////////////////////////////////////////////////////////////////////////////////
//GIF


	private static $GIF_SIGNATURE = "\x47\x49\x46"; /* "GIF" */
	private static $GIF_SIGNATURE_LEN=3;
	private static $GIF_VERSION   = "\x38\x39\x61"; /* "89a" */
	private static $GIF_VERSION_LEN=3;
	private static $GIF_HEADER_LENGTH = 7;
	private static $GIF_COLOR_TABLE_OFFSET = 4;
	private static $GIF_GLOBAL_COLOR_TABLE_BIT  = 0x80;
	private static $GIF_GLOBAL_COLOR_TABLE_BITS = 0x07;
	private static $GIF_RGB = 3;
	private static $GIF_COMMENT_EXTENSION_BLOCK_ID   = "\x21\xfe";
	private static $GIF_BLOCK_TERMINATOR               = '\00';
	private static $GIF_COMMENT_EXTENSION_BLOCK_COMP_LEN = 4; /* + text */
	private static $GIF_COPYRIGHT	="\x21\xfe\x1bkddi_copyright=on,copy=\"NO\"\0";

	private  static function GIFCheckSignature($fnR){

		if (self::$GIF_SIGNATURE === fread($fnR,self::$GIF_SIGNATURE_LEN)){
			return self::$GIF_SIGNATURE;
		}
		return false;
	}
	private  static function GIFCheckVersion($fnR){
		if (self::$GIF_VERSION === fread($fnR,self::$GIF_VERSION_LEN)){
			return self::$GIF_VERSION;
		}
		return false;
	}
	private  static function GIFSkipGCT($fnR){
		$buf=fread($fnR,self::$GIF_COLOR_TABLE_OFFSET);
		$gct=fread($fnR,1);
		$buf.=$gct;
		$gcta=unpack('C*',$gct);

		if(($gcta[1] & self::$GIF_GLOBAL_COLOR_TABLE_BIT)==self::$GIF_GLOBAL_COLOR_TABLE_BIT){
			$len=1<< (($gcta[1] & self::$GIF_GLOBAL_COLOR_TABLE_BITS)+1);


			$buf.=fread($fnR, $len * self::$GIF_RGB+2);

		}
		return $buf;
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////
//各呼び出し

	/**
	 * PNGに転送禁止フラグを付与
	 * @author   stanaka
	 * @since    2011/06/02
	 *
	 * @param unknown_type $fnR
	 * @param unknown_type $fnW
	 * @return string|string
	 */
	public static function PNGAdd($fnR,$fnW,$header=true){
			if($header){
			header('Content-Type: image/png');
			header('x-jphone-copyright: no-store, no-transfer, no-peripheral');
		}
		//シグネチャチェック
		$buf=self::PNGCheckSignature($fnR);
		if($buf===false){return false;}
		//シグネチャ出力
		fwrite($fnW,$buf);
		//補助チャンクまでスキップ
		fwrite($fnW,fread($fnR,self::$PNG_IHDR_LEN));
		//TEXTチャンク出力
		//fwrite($fnW,self::CreatePngChunk(self::$PNG_TEXT_CHUNK_TYPE,$text));
		//fwrite($fnW,self::CreatePngChunk(self::$PNG_TEXT_CHUNK_TYPE,$text));
		fwrite($fnW,self::$PNG_COPYRIGHT_BIN);
		//残り全部
		while (!feof($fnR)) {
			fwrite($fnW,fread($fnR,self::$READ_BYTE));
		}
		return true;

	}

	/**
	 * GIFに転送禁止フラグを付与
	 * @author   stanaka
	 * @since    2011/06/02
	 *
	 * @param unknown_type $fnR
	 * @param unknown_type $fnW
	 * @return string|string
	 */
	public static function GIFAdd($fnR, $fnW,$header=true){
		//HTTPヘッダ送信
		if($header){
			header('Content-Type: image/gif');
			header('x-jphone-copyright: no-store, no-transfer, no-peripheral');
		}
		//シグネチャチェック
		$buf=self::GIFCheckSignature($fnR);
		if($buf===false){return false;}
		fwrite($fnW,$buf);

		//フォーマットVチェック
		$buf=self::GIFCheckVersion($fnR);
		if($buf===false){return false;}
		fwrite($fnW,$buf);

		//GCT領域スキップ
		$buf=self::GIFSkipGCT($fnR);
		if($buf===false){return false;}
		fwrite($fnW,$buf);

		//コメント埋め込み
		fwrite($fnW,self::$GIF_COPYRIGHT);
		//残り全部
		while (!feof($fnR)) {
			fwrite($fnW,fread($fnR,self::$READ_BYTE));
		}
		return true;
	}

	/**
	 * JPGに転送禁止フラグを付与
	 * @author   stanaka
	 * @since    2011/06/02
	 *
	 * @param unknown_type $fnR
	 * @param unknown_type $fnW
	 * @return string|string
	 */
	public static function JPGAdd($fnR, $fnW,$header=true){
		if($header){
			header('Content-Type: image/jpeg');
			header('x-jphone-copyright: no-store, no-transfer, no-peripheral');
		}
		$comment='kddi_copyright=on,copy="NO"';
		$buf = '';
		$com = "\xFF\xFE" . pack('n*', strlen($comment)+2) . $comment ;
		$skip = false;
		$skip_count = 0;

		$fh=$fnR;
		//$fh =fopen('data://text/plain;base64,'.base64_encode(stream_get_contents($fnR)),'rb');

		$bytear=unpack('C*',stream_get_contents($fnR));


			//$byte=fread($fh, 1);
			$cnt=count($bytear)+1;
			//foreach($bytear as $byteC){
			for($i=1;$i<$cnt;$i++){
				$byte=pack('C*',$bytear[$i]);
				if ($skip){
					$skip_count--;
					if($skip_count < 0){
						if (preg_match("/[\xE0-\xEF]/", $byte) == 0) {
							$buf .= $com;
						}
						$skip_count = 0;
						$skip = false ;
					}
				}elseif ($byte=="\xFF"){
					$i++;
					$byte .=pack('C*',$bytear[$i]);
					if (preg_match("/[\xE0-\xEF]/", $byte) != 0) {
						$app_length_part=pack('C*',$bytear[$i+1]);
						$app_length_part.=pack('C*',$bytear[$i+2]);
						$i+=2;
//					  $app_length_part = fread($fh, 2);
						$byte .= $app_length_part ;
						$unpack = unpack('n*', $app_length_part);

						$skip_count = $unpack[1] - 2;
						$skip = true ;
					}
				}
				$buf .= $byte;
			}


		fwrite($fnW,$buf);
		return true;
	}
}

$path=$_SERVER['DOCUMENT_ROOT'].$_SERVER['REDIRECT_URL'];
$path=str_ireplace(
	array('_sel_.gif','_sel_.jpg','_sel_.jpz','_sel_.png','_sel_.pnz','_sel_.jpeg'),
	array('.gif','.jpg','.jpg','.png','.png','.jpeg')
	,$path);
$ext=substr($path,-4);

//$fnR=fopen('php://stdin','rb');
if(!file_exists($path)){
header("HTTP/1.1 404 Not Found");
header('hello: php2!');

	exit;
}
$fnR=fopen($path,'rb');

$fnW=fopen('php://output','wb');

header('hello: php2!');
switch($ext){
case '.jpg':
case 'jpeg':
	MobileImageAddCopyFlag::JPGAdd($fnR,$fnW);
	break;
case '.gif':
	MobileImageAddCopyFlag::GIFAdd($fnR,$fnW);
	break;
case '.png':
	MobileImageAddCopyFlag::PNGAdd($fnR,$fnW);
	break;
}
fclose($fnR);
fclose($fnW);
exit;
