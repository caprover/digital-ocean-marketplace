# DigitalOcean Marketplace Partner Tools

Taken from https://github.com/digitalocean/marketplace-partners
commit: a26b53be53580ede3ee325c78e766202b1766957

- Ensure `DIGITALOCEAN_TOKEN` env var is set up. `echo $DIGITALOCEAN_TOKEN`
- Personal Token can be generated from here: https://docs.digitalocean.com/reference/api/create-personal-access-token/
- Search for `VAR_CAPROVER_VERSION` and replace with a new version like `1.10.1` - Do not use "v" prefix
- Run `packer build marketplace-image.json`
- Upload new snapshot: https://marketplace.digitalocean.com/vendorportal


