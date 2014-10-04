# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary server in each group
# is considered to be the first unless any hosts have the primary
# property set.  Don't declare `role :all`, it's a meta role.

role :app, %w{dev@203.76.108.68}
role :web, %w{dev@203.76.108.68}
role :db,  %w{dev@203.76.108.68}


# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server definition into the
# server list. The second argument is a, or duck-types, Hash and is
# used to set extended properties on the server.

server '203.76.108.68', user: 'dev', roles: %w{web app db}, primary: true


# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult[net/ssh documentation](http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start).
#
# Global options
# --------------
  set :ssh_options, {
    keys: %w(/home/dev/.ssh/id_rsa),
    forward_agent: false,
    auth_methods: %w(password),
      password: 'Welc0me2u'
  }
#
# And/or per server (overrides global)
# ------------------------------------
# server '203.76.108.68',
#   user: 'dev',
#   roles: %w{web app},
#   ssh_options: {
#     user: 'app', # overrides user setting above
#     keys: %w(/home/dev/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: 'please use keys'
#   }
