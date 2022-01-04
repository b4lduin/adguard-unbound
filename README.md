# **Adguard Home with Unbound**
## **Fork of: [lolgast1987/adguard-unbound](https://github.com/lolgast1987/adguard-unbound)**

### **Intentions**
1. Use latest Versions of Unbound & Adguard Home.
2. Perfomance Optimizations to Unbound for my local server.

### **Info**
Container combining AdGuard Home and Unbound. I don't like the fact you cannot use 127.0.0.1 as an Upstream DNS server when trying to combine these two programs as seperate containers. The only way I found was using the Docker container IP address, which to me isn't reliable enough.

### **Versions**
Base: alpine:latest \
Unbound: latest \
AdGuardHome: latest

Use the same volumemappings as the original AdGuardHome container. In fact, you can just swap in this image and everything still works. You only have to update your Upstream DNS server to __127.0.0.1:5053__, which enables Unbound.

As with the original AdGuardHome image, this exposes the following: \
**Volumes:** \
/opt/adguardhome/work \
/opt/adguardhome/conf

For Unbound: \
/opt/unbound (Needs unbound.conf)

### **Ports mappings you may need:**
1. **For plain DNS**
   - 53:53 tcp & udp
2. **For using Adguard as DHCP (I am not using this)**
   - 67:67 udp
   - 68:68 tcp & udp
3. **For using the Adguard Home Admin Panel**
   - **[port you like]**:80 tcp
   - **[port you like]**:443 tcp & udp
   - **[port you like]**:3000 tcp (for the setup)
   > this needs to be three different ports
4. **For DNS-over-TLS server**
   - 853:853 tcp
5. **For DNS-over-QUIC server**
   - 784:784 udp
   - 853:853 udp
   - 8853:8853 udp
6. **For running AdGuard Home as a DNSCrypt server**
   - 5443:5443 tcp & udp
7. **For unbound**
   - 5053 tcp & udp
