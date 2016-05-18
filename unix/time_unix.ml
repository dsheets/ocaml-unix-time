(*
 * Copyright (c) 2016 David Sheets <sheets@alum.mit.edu>
 *
 * Permission to use, copy, modify, and distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *
 *)

module Type = Unix_time_types.C(Unix_time_types_detected)
module C = Unix_time_bindings.C(Unix_time_generated)

let time_to_int64 x =
  Int64.of_int (PosixTypes.Time.to_int x) (*PosixTypes.Time.to_int64*)
let time_of_int64 x =
  PosixTypes.Time.of_int (Int64.to_int x) (*PosixTypes.Time.of_int64*)

module Timespec = struct
  let t = Ctypes.view
      ~read:(fun c -> Time.Timespec.({
        sec  = time_to_int64 (Ctypes.getf c Type.Timespec.tv_sec);
        nsec = Signed.Long.to_int (Ctypes.getf c Type.Timespec.tv_nsec);
      }))
      ~write:(fun { Time.Timespec.sec; nsec } ->
        let timespec = Ctypes.(!@ (allocate_n Type.Timespec.t ~count:1)) in
        Ctypes.setf timespec Type.Timespec.tv_sec (time_of_int64 sec);
        Ctypes.setf timespec Type.Timespec.tv_nsec (Signed.Long.of_int nsec);
        timespec
      )
      Type.Timespec.t
end
