FROM nginx:alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY index.html /usr/share/nginx/html/index.html
COPY sms-consent.html /usr/share/nginx/html/sms-consent.html
COPY privacy.html /usr/share/nginx/html/privacy.html
COPY terms.html /usr/share/nginx/html/terms.html
COPY policy-style.css /usr/share/nginx/html/policy-style.css
EXPOSE 80
