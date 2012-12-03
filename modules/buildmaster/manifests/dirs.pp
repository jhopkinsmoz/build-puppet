class buildmaster::dirs {

    file {
        [ "${master_dir}",
          "${master_dir}/${master_name}",
          "${master_dir}/${master_name}/${master_type}",
          "${virtualenv_dir}":
          "${queue_dir}",
        ]:
            owner => $users::builder::username,
            group => $users::builder::group,
            ensure => directory,
            mode => 0755;
    }
}