# ziggybook.ai DNS

This folder holds the DNS zone file template for `ziggybook.ai`. It configures:

- **Resend email sending** (so `noreply@ziggybook.ai` can send booking notifications)
- **DMARC** monitoring
- **CAA** records (lock SSL issuance to Let's Encrypt + Google Trust Services)
- Optional **Google Workspace** inbound email (commented out — uncomment when ready)

## Before you import

1. Open https://resend.com/domains
2. Click **Add Domain** → enter `ziggybook.ai`
3. Resend will show you 3 DNS records with values unique to your account (an MX region, an SPF string, and a DKIM public key)
4. Open `ziggybook.ai.zone` in an editor
5. Find every instance of `FROM_RESEND_DASHBOARD` and replace it with the actual values Resend gave you. Do the same for the region in the MX record if Resend shows a region other than `us-east-1`.
6. Save

## Importing to Cloudflare

1. Go to https://dash.cloudflare.com → ziggybook.ai → **DNS** → **Records**
2. Click the `...` menu (top right corner of the Records table) → **Import and Export**
3. Click **Import DNS records** and upload the edited `ziggybook.ai.zone` file
4. Review the preview Cloudflare shows — make sure it's adding records, not deleting them
5. Click **Import**

## After you import

1. **Toggle DKIM records to "DNS only" (gray cloud)** — Cloudflare's proxy breaks DKIM signatures. The record to check is `resend._domainkey.ziggybook.ai`. It MUST be gray cloud.
2. Go back to https://resend.com/domains → click **Verify** on your ziggybook.ai entry
3. Propagation on Cloudflare is usually 2-5 minutes
4. Once Resend shows "verified" (green), update `NOTIFICATIONS_FROM_EMAIL` in Coolify (or the smartbook-api `.env` locally) to `noreply@ziggybook.ai`
5. Redeploy smartbook-api

## What's NOT in this file (already in Cloudflare)

- `A @ → 159.203.174.128` (droplet, proxied)
- `CNAME www → ziggybook.ai` (proxied)

These are skipped to avoid duplicates on import.
