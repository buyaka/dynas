NoBrainer.configure do |config|
  # The rethinkdb_url specifies the RethinkDB database connection url.
  # When left unspecified, NoBrainer picks a database connection by default.
  # The default is to use localhost, with a database name matching the
  # Rails application name and the Rails environment.
  # NoBrainer also reads environment variables when defined:
  # * RETHINKDB_URL, RDB_URL
  # * RETHINKDB_HOST, RETHINKDB_PORT, RETHINKDB_DB, RETHINKDB_AUTH
  # * RDB_HOST, RDB_PORT, RDB_DB, RDB_AUTH

  #config.rethinkdb_url = config.default_rethinkdb_url
  #config.RDB_HOST = 127.0.0.1
  #config.RDB_PORT = 28015
  #config.RDB_DB = dynas
  #config.RDB_AUTH = unimedia
  #config.rethinkdb_url = "rethinkdb://localhost/dynas"
  config.rethinkdb_url = "rethinkdb://192.168.100.213/dynas_new"

  # NoBrainer uses logger to emit debugging information.
  # The default logger is the Rails logger if run with Rails,
  # otherwise Logger.new(STDERR) with a WARN level.
  # If the logger is configured with a DEBUG level,
  # then each database query is emitted.
  config.logger = config.default_logger

  # NoBrainer will colorize the queries if colorize_logger is true.
  # Specifically, NoBrainer will colorize management RQL queries in yellow,
  # write queries in red and read queries in green.
  config.colorize_logger = true

  # You probably do not want to use both NoBrainer and ActiveRecord in your
  # application. NoBrainer will emit a warning if you do so.
  # You can turn off the warning if you want to use both.
  config.warn_on_active_record = true

  # auto_create_databases allows NoBrainer to create databases on demand.
  # This behavior is similar to MongoDB.
  config.auto_create_databases = true

  # auto_create_tables allows NoBrainer to create tables on demand.
  # This behavior is similar to MongoDB.
  # Note that this will not auto create indexes for you.
  # You still need to run `rake db:update_indexes` to create the indexes.
  config.auto_create_tables = true

  # When the network connection is lost, NoBrainer will try running a given
  # query 10 times before giving up. Note that this can be a problem with non
  # idempotent write queries such as increments.
  # Setting it to 0 disable reconnections.
  config.max_retries_on_connection_failure = 10

  # Configures the durability for database writes.
  # The default durability is :hard, unless when running with Rails in test or
  # development mode, for which the durability mode is :soft.
  config.durability = config.default_durability

  # user_timezone can be configured with :utc, :local, or :unchanged.
  # When reading an attribute from a model which type is Time, the timezone
  # of that time is translated according to this setting.
  # config.user_timezone = :local # only on git HEAD

  # db_timezone can be configured with :utc, :local, or :unchanged.
  # When writting to the database, the timezone of Time attributes are
  # translated according to this setting.
  # config.db_timezone = :utc # only on git HEAD

  # Configures which mechanism to use in order to perform non-racy uniqueness
  # validations. Read more about this behavior in the validation section.
  config.distributed_lock_class = nil
end

