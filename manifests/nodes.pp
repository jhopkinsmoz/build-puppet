node /bld-centos6-hp-\d+.build.scl1.mozilla.com/ {
    include toplevel::slave::build::mock
}

node "relabs07.build.mtv1.mozilla.com" {
    $num_masters = 1
    include toplevel::server::buildmaster::build
}

node "relabs08.build.mtv1.mozilla.com" {
    include toplevel::slave::build::mock
}

node "relabs-buildbot-master.build.mtv1.mozilla.com" {
    include toplevel::server
}

node "relabs-slave.build.mtv1.mozilla.com" {
    include toplevel::slave::test
}

node /foopy\d+.build.mtv1.mozilla.com/ {
    include toplevel::server::foopy
}

node /foopy\d+.build.scl1.mozilla.com/ {
    include toplevel::server::foopy
}

node /foopy\d+.p\d+.releng.scl1.mozilla.com/ {
    include toplevel::server::foopy
}

node "linux-foopy-test.build.mtv1.mozilla.com" {
    include toplevel::server::foopy
}

node /talos-mtnlion-r5-\d+.test.releng.scl3.mozilla.com/ {
    include toplevel::slave::test
}

node /seamicro-test\d+.build.releng.scl3.mozilla.com/ {
    include toplevel::slave::build::mock
}

node /seamicro-test\d+.try.releng.scl3.mozilla.com/ {
    include toplevel::slave::build::mock
}

node /.*\.build\.aws-.*\.mozilla\.com/ {
    # Make sure we get our /etc/hosts set up
    class {
        "network::aws": stage => network,
    }
    include toplevel::slave::build::mock
}

node /puppetmaster-\d+\..*\.aws-.*\.mozilla\.com/ {
    include toplevel::server::puppetmaster::standalone
}

# this host will die soon - it's for testing/devel
node "mobile-services.build.scl1.mozilla.com" {
    $extra_root_keys = [ 'mcote' ]
    $is_bmm_admin_host = false
    $mozpool_staging = false
    include toplevel::server::mozpool
}

# staging server per bug 815758; this must come before the general regexp below
node /mobile-imaging-001\.p\d+\.releng\.scl1\.mozilla\.com/ {
    $extra_root_keys = [ 'mcote' ]
    $mozpool_staging = true
    # staging has no admin host; db is manually maintained
    $is_bmm_admin_host = false
    include toplevel::server::mozpool
}

node /mobile-imaging-\d+\.p\d+\.releng\.scl1\.mozilla\.com/ {
    $extra_root_keys = [ 'mcote' ]
    $is_bmm_admin_host = $fqdn ? { /^mobile-imaging-002/ => 1, default => 0 }
    $mozpool_staging = false
    include toplevel::server::mozpool
}
