root = "/home/deployer/apps/lims/current"
working_directory "/home/deployer/lims"
pid "/home/deployer/lims/tmp/pids/unicorn.pid"
stderr_path "/home/deployer/lims/log/unicorn.log"
stdout_path "/home/deployer/lims/log/unicorn.log"

listen "/tmp/unicorn.todo.sock"
worker_processes 2
timeout 30