class cachenameserver::install {
	package { "cachenameserver":
        name    => "caching-nameserver",
		ensure  => installed;
	}
}
