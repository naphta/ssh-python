ssh-python
============

Bindings for libssh_ C library.

.. image:: https://img.shields.io/badge/License-LGPL%20v2-blue.svg
   :target: https://pypi.python.org/pypi/ssh-python
   :alt: License
.. image:: https://img.shields.io/pypi/v/ssh-python.svg
   :target: https://pypi.python.org/pypi/ssh-python
   :alt: Latest Version

Installation
_____________

Currently only installation from source is provided. Binary wheels to follow.

To install from source, run the following:

.. code-block:: shell

   pip install ssh-python


Project is beta status.


Prerequisites
--------------

* OpenSSL *or* gcrypt library and development headers
* Optionally Zlib library and development headers for compression

``Libssh`` source code is embedded in this project and will be built when installation is triggered per above instructions. Versions of ``libssh`` other than the one embedded in this project are not supported.


Quick Start
_____________


.. code-block:: python

   from __future__ import print_function

   import os
   import pwd

   from ssh.session import Session
   from ssh import options

   USERNAME = pwd.getpwuid(os.geteuid()).pw_name
   HOST = 'localhost'

   s = Session()
   s.options_set(options.HOST, HOST)
   s.connect()

   # Authenticate with agent
   s.userauth_agent(USERNAME)

   chan = s.channel_new()
   chan.open_session()
   chan.request_exec('echo me')
   size, data = chan.read()
   while size > 0:
       print(data.strip())
       size, data = chan.read()
   chan.close()

Output:

.. code-block:: shell

  me


Features
_________

The library uses `Cython`_ based native code extensions as wrappers to ``libssh``.

* Thread safe - GIL is released as much as possible
* Very low overhead thin wrapper
* Object oriented - memory freed automatically and safely as objects are garbage collected by Python
* Use Python semantics where applicable, such as context manager and iterator support for opening and reading from channels and SFTP file handles
* Raise errors as Python exceptions


.. _libssh: https://www.libssh.org
.. _Cython: https://www.cython.org
