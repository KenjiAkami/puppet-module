<?php
/**
* 動的転送禁止フラグ付与
*
* @author    stanaka
* @since 　　2011/08/10
* @version 　$Revision: 4.00
* @package  101VENUS-Common
* @subpackage 動的に転送禁止フラグを付ける
*/


//HTTP経由でファイルを取得する際のデフォルト向け先
define('HTTP_BACKEND','127.0.0.1');
//HOSTにポート指定がある場合無視するか(true=無視)
define('DISABLE_PORT',true);
//バージョン情報
define('VERSION',1);

define('VENUS_IMGPATH_HASH_KEY',	'fdsmH|cfdslJSDAana)*jA4%$');
//define('VENUS_IMGPATH_HASH_KEY',       'CROOZ');

define('VENUS_IMGPATH_URL_PREFIX',	'/img/enc/');
define('READ_BYTE',                 65536);
echo genurl('/img/enc/s3/card/large/1.jpg');
function genurl($d,$suffix=VENUS_IMGPATH_HASH_KEY,$urlprefix=VENUS_IMGPATH_URL_PREFIX){
        if(0!==strpos($d,$urlprefix)){return $d;}
        if(preg_match('/\.(jpe?g|gif|png|swf)$/',$d,$m)){
                $ext=$m[0];
        }else{
                $ext='.jpg';
        }
        $d=substr($d,strlen($urlprefix));
        $b64 = rtrim(base64_encode($d),'=');
        $hash= sha1($b64.$suffix);
        $url=substr($hash,0,10).$b64;
        return $urlprefix.$url.$ext;
}

function decurl($suffix=VENUS_IMGPATH_HASH_KEY,$urlprefix=VENUS_IMGPATH_URL_PREFIX){
	$path=$_SERVER['REDIRECT_URL'];
	if($path==''){$path=$_SERVER['REQUEST_URI'];}
	if(0!==strpos($path,$urlprefix)){return $path;}
	
	$ret=preg_match('/^\/img\/enc\/(.{10})(.+)\.(jpe?g|png|gif|swf)$/',$path,$m);
	if(!$ret){return false;}
	$hash           =$m[1];
	$digest         =$m[2];
	$genhash        =substr(sha1($digest . $suffix),0,10);
	if($genhash == $hash && $hash!=''){
//		return base64_decode($digest);
		return $urlprefix.base64_decode($digest);
	}
	return false;
}
function genHeader($path){
	$ext = array(
		'/\.jpg$/' => 'image/jpeg',
		'/\.png$/' => 'image/png',
		'/\.gif$/' => 'image/gif',
		'/\.swf$/' => 'application/x-shockwave-flash',
	);
	foreach($ext as $k => $v){
		if(preg_match($k,$path)){
			header('Content-Type: '.$v);
		}
	}
}
/**
* 
* メイン処理
*/
function main(){
	$path=decurl();

	if($path === false){
		//404
		header("HTTP/1.1 404 Not Found");
		header('X-OBF: invalid');
		exit;
	}
	genHeader($path);
	//ファイル取得をHTTP経由で行うかストレージ直か
	if($_GET['mode']=='proxy'){
		$fnR=gen_http_h($path);
	}else{
		$fnR=gen_file_h($path);
	}
        if($fnR===false){
		header("HTTP/1.1 404 Not Found");
		header('X-OBF: un');
		exit;
        }
	header('X-OBF: ok');
	$fnW=fopen('php://output','wb');
	while (!feof($fnR)) {
		fwrite($fnW,fread($fnR,READ_BYTE));
	}
	
	
	//後始末
	fclose($fnR);
	fclose($fnW);
	exit;
}

/////////////////////////////////////////////////////////////////////
//HTTPリクエスト用のハンドル作成
function gen_http_h($path,$req=HTTP_BACKEND){
	$nhost='';
	if(DISABLE_PORT===true){
		$sphost=explode(':',$_SERVER['HTTP_HOST']);
		$nhost=$sphost[0];
	}else{
		$nhost=$_SERVER['HTTP_HOST'];
	}
	
	$opts = array(
		'http'=>array(
			'method'=>'GET',
			'header'=>'Host: '.$nhost."\r\n"	
		)
	);
	$port='';
	if($_SERVER['SERVER_PORT']!='80' && DISABLE_PORT!==true){
		$port=':'.$_SERVER['SERVER_PORT'];
	}
	$reqpath='http://'.$req.$port.$path;
	$context = stream_context_create($opts);
	$fp = fopen($reqpath, 'r', false, $context);
	return $fp;
}

//FILEリクエスト用のハンドル作成
function gen_file_h($path){
	$path=$_SERVER['DOCUMENT_ROOT'].$path;
	if(!file_exists($path)){
		return false;
	}
	$fnR=fopen($path,'rb');
	return $fnR;
}
/////////////////////////////////////////////////////////////////////
main();

