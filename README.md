ocaml-unix-time
===============

[ocaml-unix-time](https://github.com/dsheets/ocaml-unix-time)
provides access to the features exposed in
[`time.h`][time.h] in a way that is not tied to the
implementation on the host system.

The [`Time`][time] module provides types and functions
for describing and working with time.h structures like `tm`, `timespec`,
and `itimerspec`.

The [`Time_unix`][time_unix] module provides bindings to
functions that use the types in `Time`.

[time.h]: http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/time.h.html
[time]: https://github.com/dsheets/ocaml-unix-time/blob/master/lib/time.mli
[time_unix]: https://github.com/dsheets/ocaml-unix-time/blob/master/unix/time_unix.mli
[lwt]: http://ocsigen.org/lwt/
