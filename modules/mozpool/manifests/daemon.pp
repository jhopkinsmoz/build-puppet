class mozpool::daemon {
    include mozpool::settings
    include mozpool::virtualenv

    # run the daemon on port 8010; Apache will proxy there
    supervisord::supervise {
      "mozpool-server":
         command => "${::mozpool::settings::root}/frontend/bin/mozpool-server 8010",
         user => 'apache',
         environment => [ "MOZPOOL_CONFIG=${::mozpool::settings::config_ini}" ],
         require => Class['mozpool::virtualenv'],
         extra_config => "stderr_logfile=/var/log/mozpool.log\nstderr_logfile_maxbytes=10MB\nstderr_logfile_backups=10\n";
    }
}
