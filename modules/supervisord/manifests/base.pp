# NB: This is specific to supervisord version 2
class supervisord::base {
    include packages::mozilla::supervisor

    file {
        "/etc/supervisord.conf":
            source => "puppet:///modules/supervisord/supervisord.conf";

        "/etc/supervisord.d/":
            notify => Service["supervisord"],
            ensure => directory,
            recurse => true,
            purge => true;
        "/etc/supervisord.conf.d/":
            recurse => true,
            force => true,
            ensure => absent;

    }

    service {
        "supervisord":
            require => [
                Class["packages::mozilla::supervisor"],
                File["/etc/supervisord.conf"],
            ],
            restart => "/usr/bin/supervisorctl reload",
            enable => true,
            ensure => running;
    }
}
