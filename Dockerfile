FROM alpine:latest
 
RUN apk add --no-cache \
	unbound

WORKDIR /tmp

RUN wget https://www.internic.net/domain/named.root -qO- >> /etc/unbound/root.hints

COPY files/ /opt/

# AdGuardHome latest
RUN wget https://github.com/AdguardTeam/AdGuardHome/releases/latest/download/AdGuardHome_linux_amd64.tar.gz >/dev/null 2>&1 \
	&& mkdir -p /opt/adguardhome/conf /opt/adguardhome/work \
	&& tar xf AdGuardHome_linux_amd64.tar.gz ./AdGuardHome/AdGuardHome  --strip-components=2 -C /opt/adguardhome \
	&& /bin/ash /opt/adguardhome \
	&& chown -R nobody: /opt/adguardhome \
	&& setcap 'CAP_NET_BIND_SERVICE=+eip CAP_NET_RAW=+eip' /opt/adguardhome/AdGuardHome \
	&& chmod +x /opt/entrypoint.sh \
	&& rm -rf /tmp/* /var/cache/apk/*

WORKDIR /opt/adguardhome/work

VOLUME ["/opt/adguardhome/conf", "/opt/adguardhome/work", "/opt/unbound"]

EXPOSE 53/tcp 53/udp 67/udp 68/tcp 68/udp 80/tcp 443/tcp 443/udp 3000/tcp 853/tcp 784/udp 853/udp 8853/udp 5443/tcp 5443/udp 5053/udp 5053/tcp

HEALTHCHECK --interval=30s --timeout=15s --start-period=5s\
            CMD sh /opt/healthcheck.sh

CMD ["/opt/entrypoint.sh"]