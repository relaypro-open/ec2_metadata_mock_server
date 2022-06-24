ec2_mock
=====

A server to mock ec2 instance metadata

Build
-----

    $ mix compile


Setup
---

    On the ec2_instance you want to emulate:

    (python script requires requests library: pip install requests)

    $ ec2_metadata.py, copy output to priv/metadata.json on ec2_mock instance.  Edit as needed.

Run
---

    $ mix run --no-halt

Deploy
---
    $ mix release

    This will create both a standard Elixir Release in _build/
      _build/dev/rel/ec2_mock (start|remote|stop)
        
    and a standalone binary via Bakeware at
      _build/dev/rel/bakeware/ec2_mock

Test
---
    Manually:
    $ curl https://localhost:3000/latest/meta-data

    Unit tests:
    $ mix test
