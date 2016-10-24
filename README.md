Docker SSL Generator
====================

An image which helps with managing SSL certs.<br />
This, when started, will generate a CA cert (if one doesn't exist) and SSL cert for your use.<br />

You will be prompted for all fields (CN, Org, email, etc).<br />
You can start an container from this image N times and it will create and store whatever certs you specify.
Once created you can mount the volumes from this to whatever containers require an SSL cert using `--volumes-from`.<br />
Certs are stored in `/var/ssl/certs`

When starting the container you **must** use ***interactive mode*** so you can provide input about the certs to be created.

Quickstart
----------

Acquire the source files.

In a console/terminal that can do `docker` commands:

    docker build -t sslgen .
    docker run --name sslgen -ti sslgen

> When starting the first time, the container will create:
> - a Certificate Authority (CA)
> - the first certificate

It is done by answering the questions:

<pre>
No CA cert provided, creating a new one!
Generating a 2048 bit RSA private key
.....................................+++
writing new private key to '/var/ssl/ca/ca_key.pem'
-----
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Common Name []:<b><i>CONTOSO.COM</i></b>                # <----- here
State []:<b><i>QC</i></b>                               # <----- here (required)
Country []:<b><i>CA</i></b>                             # <----- here (2-letter country code required)
E-Mail Address []:<b><i>ADMIN@CONTOSO.COM</i></b>       # <----- here
Organization Name []:<b><i>CONTOSO</i></b>              # <----- here

Generating SSL Cert
Enter name for certificate file
<b><i>CONTOSO</i></b>                                   # <----- here
Generating a 2048 bit RSA private key
.....................................+++
writing new private key to '/var/ssl/certs/CONTOSO.key'
-----
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Common Name []:<b><i>WWW.CONTOSO.COM</i></b>            # <----- here
State []:<b><i>QC</i></b>                               # <----- here (required)
Country []:<b><i>CA</i></b>                             # <----- here (2-letter country code required)
E-Mail []:<b><i>ADMIN@CONTOSO.COM</i></b>               # <----- here
Organization Name []:<b><i>CONTOSO</i></b>              # <----- here
Organizational Unit Name []:<b><i>CONTOSO</i></b>       # <----- here
Using configuration from /var/ssl/ca_conf.cnf
Check that the request matches the signature
Signature ok
The Subject's Distinguished Name is as follows
commonName            :ASN.1 12:'WWW.CONTOSO.COM'
stateOrProvinceName   :ASN.1 12:'QC'
countryName           :PRINTABLE:'CA'
emailAddress          :IA5STRING:'ADMIN@CONTOSO.COM'
organizationName      :ASN.1 12:'CONTOSO'
organizationalUnitName:ASN.1 12:'CONTOSO'
Certificate is to be certified until Oct 17 02:42:31 2026 GMT (3650 days)

Sign the certificate? [y/n]:<b><i>y</i></b>                                  # <----- here
1 out of 1 certificate requests certified, commit? [y/n]<b><i>y</i></b>      # <----- here

Write out database with 1 new entries
Data Base Updated
</pre>

An example of using `--volumes-from`:
-------------------------------------

Create, and start:

    docker create --volumes-from sslgen --name sslgen_demo -ti alphine /bin/ash
    docker start -ai sslgen_demo

Inspect `/var/ssl`:

    ls -lR /var/ssl

