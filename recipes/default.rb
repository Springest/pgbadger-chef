git "/data/springest/pgbadger" do
  repository "https://github.com/dalibo/pgbadger.git"
  reference "a614611252c46d13f2f0cb03040c21c0b6b9a692"
  action :sync
  notifies :run, 'execute[run Makefile]', :immediately
  not_if do ::File.exists?("/usr/bin/pgbadger") end
end

execute "run Makefile" do
  cwd "/data/springest/pgbadger"
  command "perl Makefile.PL INSTALLDIRS='perl'"
  action :nothing
  notifies :run, 'execute[make and install]', :immediately
end

execute "make and install" do
  cwd "/data/springest/pgbadger"
  command "make & make install"
  action :nothing
end
