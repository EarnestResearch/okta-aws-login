# Login to AWS account via Okta (SAML) from the command line

Logs in to [AWS ECR](https://aws.amazon.com/ecr/) at the same time. Populates `$HOME/.aws/credentials` and runs `docker login` with temporary ECR credentials.

Older static binary [Releases](https://github.com/EarnestResearch/okta-aws-login/releases). Please see install notes for `nix` instructions.

# Install

See [releases](https://github.com/andreyk0/okta-aws-login/releases) for available binaries.

Initially this tool needs to be configured, you need to know:
   - Okta "embed" link for your AWS account
   - Max session duration for the AWS roles you are allowed to assume via SAML

Your system administrators should be able to provide both of these.


Example configuration (assuming you are allowed to have 12h sessions):
```bash
$ okta-aws-login configure --okta-embed-link https://YOURSITE.okta.com/home/amazon_aws/xxxxxxxxxxxxxxxxxxxx/yyy --aws-profile production --default --ecr --session-duration 43200
```

Run `okta-aws-login configure -h` for description of configuration options.

If binary releases don't work for your system you can try to install from source with [Haskell stack](https://docs.haskellstack.org/en/stable/README/#how-to-install)

```bash
stack  --local-bin-path /path/to/your/home/bin install
```


# CLI

```bash
Login to AWS via Okta/SAML.

Usage: okta-aws-login ([COMMAND] | [-V|--version] [-v|--verbose] [-u|--user ARG]
                      [-p|--aws-profile ARG] [-r|--region ARG]
                      [-c|--config-file ARG] [-k|--keep-reloading] ([--no-ecr] |
                      [--ecr]) | [-l|--list-profiles])
  Login to AWS via Okta/SAML (source:
  https://github.com/EarnestResearch/okta-aws-login) Default config file:
  "/Users/yourhome/.okta-aws-login.json"

Available options:
  -h,--help                Show this help text
  -V,--version             Print version and exit.
  -v,--verbose             Be verbose.
  -u,--user ARG            User name.
  -p,--aws-profile ARG     AWS profile. Defaults to value of AWS_PROFILE env
                           var, then to default config entry.
  -r,--region ARG          AWS region. (default: us-east-1)
  -c,--config-file ARG     Use alternative config
                           file. (default: "/Users/yourhome/.okta-aws-login.json")
  -k,--keep-reloading      Keep reloading session token hourly (that's the max
                           TTL at the moment). This only works well on a trusted
                           network where you don't need MFA.
  --no-ecr                 Skip Docker login to ECR registry, default is in the
                           config.
  --ecr                    Attempt Docker login to ECR registry, default is in
                           the config.
  -l,--list-profiles       List available AWS profiles and exit.

Available commands:
  configure                Configure AWS profile given an Okta 'embed' link

Log in using default AWS profile, you'll be prompted for user name / password: 

  $ okta-aws-login 

Specify user name and keep reloading session: 

  $ okta-aws-login --user my-okta-user-name --keep-reloading 

Log in with more than one AWS profile: 

  $ okta-aws-login --user my-okta-user-name --aws-profile my-aws-profile1 --aws-profile my-aws-profile2 

Skip ECR login (note that you can set default behavior in the config file) 

  $ okta-aws-login --no-ecr --user my-okta-user-name --aws-profile my-aws-profile1
```


# Development

Build/test from source

```bash
make
```

Build statically linked linux binaries with [static-haskell-nix](https://github.com/nh2/static-haskell-nix/).

``` bash
make build-linux-static
```

**Please note** that you need to [enable Cachix caches](https://github.com/nh2/static-haskell-nix/#binary-caches-for-faster-building-optional) for this to complete in a reasonable amount of time.


Okta [API](http://developer.okta.com/docs/api/resources/authn.html).

Okta official CLI [inspiration](https://github.com/oktadeveloper/okta-aws-cli-assume-role)


# Release

To release

* Update version X.Y.Z field in the [package.yaml](./package.yaml)
* `git tag vX.Y.Z`
* push changes and the tag, this should trigger a GH Actions build
