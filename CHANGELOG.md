# Changelog

## v0.5.2 (2019-06-10)

* Added `:redirect_uri_match_fun` configuration option for custom matching of redirect uri

## v0.5.1 (2019-05-08)

* Relaxed plug requirement up to 2.0.0
* Fix bug where otp app name could not be fetched in release

## v0.5.0 (2019-05-08)

This is a full rewrite of the library, and are several breaking changes. You're encouraged to test your app well if you upgrade from 0.4.

### Upgrading from 0.4

#### 1. Schema modules

Schema modules are now generated when installing ExOauth2Provider. To upgrade please run `mix ex_oauth2_provider.install --no-migrations` to generate the schema files.

In the `MyApp.OauthAccessGrants.OauthAccessGrant` schema module you should update the `timestamp/0` macro to ignore `:updated_at`:

```elixir
  schema "oauth_access_grants" do
    access_grant_fields()

    timestamps(updated_at: false)
  end
```

#### 2. Configuration

Config now has the form `config :my_app, ExOauth2Provider`. You can still use the previous `config :ex_oauth2_provider, ExOauth2Provider` configuration, but you are encouraged to switch over to the app specific configuration.

#### 3. Resource owner UUID configuration

If your configuration has `:resource_owner` setting with a UUID, you should remove it and only use the module name for your user schema. UUID is now handled in the schema modules directly.

The schemas can be generated with `mix ex_oauth2_provider.install --no-migrations --binary-id`.