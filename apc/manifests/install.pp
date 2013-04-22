class apc::install {
    pecl::php::pecl_package {"apc-3.1.9": 
        require => Class["apache::install"],
    }
}
