Docker SSL Generator
====================

An image which helps with managing SSL certs.<br />
This, when started, will generate a CA cert (if one doesn't exist) and SSL cert for your use.<br />

You will be prompted for all fields (CN, Org, email, etc).<br />
You can start an container from this image N times and it will create and store whatever certs you specify.
Once created you can mount the volumes from this to whatever containers require an SSL cert using --volumes-from.<br />
Certs are stored in /var/ssl/certs

When starting the container you must use interactive mode so you can provide input about the certs to be created.
