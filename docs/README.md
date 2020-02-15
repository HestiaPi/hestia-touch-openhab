# Documentation
This directory holds the owner's manual for the Hestia project, including an
[owners manual](hestiapi-one.pdf).  In addition to the documentation here,
there is also the [community forum](https://community.hestiapi.com/) and the
[wiki on GitHub](https://github.com/HestiaPi/hestia-touch-openhab/wiki).

LaTeX (pronounced LAH tech or LAY tech) is used to generate the PDF owners
manual, which should cover all normal operations, configuration, and provide
a starting point to people who want to start hacking things up to improve or
just customize their Hestia.

If there's something the manual should have, but doesn't, the community forum
is the first place to turn.  Please mention that you weren't able to find the
answer in the documentation.  This should get you the help you need, and once
the question is answered someone (perhaps even you!) can update the
documentation to make things easier for the next person.


# Updating Documentation
LaTeX is an entirely text based language.  All you'll need to make changes
is a text editor, however to see those changes in a PDF, you'll need some
additional tools to rebuild the PDF document.

The formatting rules for LaTeX can be complicated, but the good news is that
the complicated things are seldom needed in practice.  Usually you can just
copy text from another section and it'll work just fine.

## Rebuilding the PDF
If you are using a Debian-based Linux distrubution, just run "make deps" from
this directory and it will install everything you need.  If you want to
build the PDF using another Linux Distro, or another operating system, hop on
the community forum and ask for help (if nobody responds, mention
hestia_hacker by name so they get an email).  Someone can point you to where
to get the tools, and potentially even update the Makefile so "make deps"
works on Fedora (or whatever distro you're interested in).

After you have the required software, creating the PDF is just a matter of
running "make" from this directory (the docs directory).
