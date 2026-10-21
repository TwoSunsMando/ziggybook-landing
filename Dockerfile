# QUEUE #17 (Trivy DS-0002): official unprivileged nginx (runs as uid 101,
# pid + temp paths in /tmp). It still listens on 80 from our nginx.conf, so
# the Coolify port mapping is unchanged: Docker >= 20.10 sets
# net.ipv4.ip_unprivileged_port_start=0 inside containers, which lets a
# non-root process bind 80.
FROM nginxinc/nginx-unprivileged:alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY index.html /usr/share/nginx/html/index.html
COPY sms-consent.html /usr/share/nginx/html/sms-consent.html
COPY sms-signup.html /usr/share/nginx/html/sms-signup.html
COPY privacy.html /usr/share/nginx/html/privacy.html
COPY terms.html /usr/share/nginx/html/terms.html
COPY contact.html /usr/share/nginx/html/contact.html
COPY policy-style.css /usr/share/nginx/html/policy-style.css
COPY help/ /usr/share/nginx/html/help/
EXPOSE 80
# Container health = nginx answers / (busybox wget; no curl in alpine).
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD wget -q -O /dev/null http://127.0.0.1/ || exit 1
USER 101
