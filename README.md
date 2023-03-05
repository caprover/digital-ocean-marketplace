# DigitalOcean Marketplace Partner Tools

Taken from https://github.com/digitalocean/marketplace-partners
commit: c17018a3f31aa9db08fa5bc7cafb9d21ed2c967c

- Ensure `DIGITALOCEAN_TOKEN` env var is set up. `echo $DIGITALOCEAN_TOKEN`
- Personal Token can be generated from here: https://docs.digitalocean.com/reference/api/create-personal-access-token/
- Search for `VAR_CAPROVER_VERSION` and replace with a new version like `1.10.1` - Do not use "v" prefix:
```
find . -type f -name "*" -exec sed -i'' -e 's/VAR_CAPROVER_VERSION/1.10.1/g' {} +
```
- Run `packer build marketplace-image.json`
- Upload new snapshot: https://marketplace.digitalocean.com/vendorportal


