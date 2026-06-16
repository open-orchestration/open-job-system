## [ØMQ - The Guide](https://zguide.zeromq.org/)

- [Preface](https://zguide.zeromq.org/docs/preface/)
- [1\. Basics](https://zguide.zeromq.org/docs/chapter1/)
- [2\. Sockets and Patterns](https://zguide.zeromq.org/docs/chapter2/)
- [3\. Advanced Request-Reply Patterns](https://zguide.zeromq.org/docs/chapter3/)
- [4\. Reliable Request-Reply Patterns](https://zguide.zeromq.org/docs/chapter4/)
- [5\. Advanced Pub-Sub Patterns](https://zguide.zeromq.org/docs/chapter5/)
- [6\. The ZeroMQ Community](https://zguide.zeromq.org/docs/chapter6/)
- [7\. Advanced Architecture using ZeroMQ](https://zguide.zeromq.org/docs/chapter7/)
- [8\. A Framework for Distributed Computing](https://zguide.zeromq.org/docs/chapter8/)
- [Postface](https://zguide.zeromq.org/docs/postface/)

![Menu](https://zguide.zeromq.org/svg/menu.svg)**1\. Basics**![Table of Contents](https://zguide.zeromq.org/svg/toc.svg)

- [Fixing the World](https://zguide.zeromq.org/docs/chapter1/#Fixing-the-World)
- [Starting Assumptions](https://zguide.zeromq.org/docs/chapter1/#Starting-Assumptions)
- [Getting the Examples](https://zguide.zeromq.org/docs/chapter1/#Getting-the-Examples)
- [Ask and Ye Shall Receive](https://zguide.zeromq.org/docs/chapter1/#Ask-and-Ye-Shall-Receive)
- [A Minor Note on Strings](https://zguide.zeromq.org/docs/chapter1/#A-Minor-Note-on-Strings)
- [A Note on the Naming Convention](https://zguide.zeromq.org/docs/chapter1/#A-Note-on-the-Naming-Convention)
- [Version Reporting](https://zguide.zeromq.org/docs/chapter1/#Version-Reporting)
- [Getting the Message Out](https://zguide.zeromq.org/docs/chapter1/#Getting-the-Message-Out)
- [Divide and Conquer](https://zguide.zeromq.org/docs/chapter1/#Divide-and-Conquer)
- [Programming with ZeroMQ](https://zguide.zeromq.org/docs/chapter1/#Programming-with-ZeroMQ)
  - [Getting the Context Right](https://zguide.zeromq.org/docs/chapter1/#Getting-the-Context-Right)
  - [Making a Clean Exit](https://zguide.zeromq.org/docs/chapter1/#Making-a-Clean-Exit)
- [Why We Needed ZeroMQ](https://zguide.zeromq.org/docs/chapter1/#Why-We-Needed-ZeroMQ)
- [Socket Scalability](https://zguide.zeromq.org/docs/chapter1/#Socket-Scalability)
- [Upgrading from ZeroMQ v2.2 to ZeroMQ v3.2](https://zguide.zeromq.org/docs/chapter1/#Upgrading-from-ZeroMQ-v-to-ZeroMQ-v)
  - [Compatible Changes](https://zguide.zeromq.org/docs/chapter1/#Compatible-Changes)
  - [Incompatible Changes](https://zguide.zeromq.org/docs/chapter1/#Incompatible-Changes)
  - [Suggested Shim Macros](https://zguide.zeromq.org/docs/chapter1/#Suggested-Shim-Macros)
- [Warning: Unstable Paradigms!](https://zguide.zeromq.org/docs/chapter1/#Warning-Unstable-Paradigms)

# [![](https://zguide.zeromq.org/images/logo.gif)](https://zguide.zeromq.org/)

# Chapter 1 - Basics  [\#](https://zguide.zeromq.org/docs/chapter1/\#basics)

## Fixing the World  [\#](https://zguide.zeromq.org/docs/chapter1/\#Fixing-the-World)

How to explain ZeroMQ? Some of us start by saying all the wonderful things it does. _It’s sockets on steroids. It’s like mailboxes with routing. It’s fast!_ Others try to share their moment of enlightenment, that zap-pow-kaboom satori paradigm-shift moment when it all became obvious. _Things just become simpler. Complexity goes away. It opens the mind._ Others try to explain by comparison. _It’s smaller, simpler, but still looks familiar._ Personally, I like to remember why we made ZeroMQ at all, because that’s most likely where you, the reader, still are today.

Programming is science dressed up as art because most of us don’t understand the physics of software and it’s rarely, if ever, taught. The physics of software is not algorithms, data structures, languages and abstractions. These are just tools we make, use, throw away. The real physics of software is the physics of people–specifically, our limitations when it comes to complexity, and our desire to work together to solve large problems in pieces. This is the science of programming: make building blocks that people can understand and use _easily_, and people will work together to solve the very largest problems.

We live in a connected world, and modern software has to navigate this world. So the building blocks for tomorrow’s very largest solutions are connected and massively parallel. It’s not enough for code to be “strong and silent” any more. Code has to talk to code. Code has to be chatty, sociable, well-connected. Code has to run like the human brain, trillions of individual neurons firing off messages to each other, a massively parallel network with no central control, no single point of failure, yet able to solve immensely difficult problems. And it’s no accident that the future of code looks like the human brain, because the endpoints of every network are, at some level, human brains.

If you’ve done any work with threads, protocols, or networks, you’ll realize this is pretty much impossible. It’s a dream. Even connecting a few programs across a few sockets is plain nasty when you start to handle real life situations. Trillions? The cost would be unimaginable. Connecting computers is so difficult that software and services to do this is a multi-billion dollar business.

So we live in a world where the wiring is years ahead of our ability to use it. We had a software crisis in the 1980s, when leading software engineers like Fred Brooks believed
[there was no “Silver Bullet”](http://en.wikipedia.org/wiki/No_Silver_Bullet) to “promise even one order of magnitude of improvement in productivity, reliability, or simplicity”.

Brooks missed free and open source software, which solved that crisis, enabling us to share knowledge efficiently. Today we face another software crisis, but it’s one we don’t talk about much. Only the largest, richest firms can afford to create connected applications. There is a cloud, but it’s proprietary. Our data and our knowledge is disappearing from our personal computers into clouds that we cannot access and with which we cannot compete. Who owns our social networks? It is like the mainframe-PC revolution in reverse.

We can leave the political philosophy
[for another book](http://cultureandempire.com/). The point is that while the Internet offers the potential of massively connected code, the reality is that this is out of reach for most of us, and so large interesting problems (in health, education, economics, transport, and so on) remain unsolved because there is no way to connect the code, and thus no way to connect the brains that could work together to solve these problems.

There have been many attempts to solve the challenge of connected code. There are thousands of IETF specifications, each solving part of the puzzle. For application developers, HTTP is perhaps the one solution to have been simple enough to work, but it arguably makes the problem worse by encouraging developers and architects to think in terms of big servers and thin, stupid clients.

So today people are still connecting applications using raw UDP and TCP, proprietary protocols, HTTP, and Websockets. It remains painful, slow, hard to scale, and essentially centralized. Distributed P2P architectures are mostly for play, not work. How many applications use Skype or Bittorrent to exchange data?

Which brings us back to the science of programming. To fix the world, we needed to do two things. One, to solve the general problem of “how to connect any code to any code, anywhere”. Two, to wrap that up in the simplest possible building blocks that people could understand and use _easily_.

It sounds ridiculously simple. And maybe it is. That’s kind of the whole point.

## Starting Assumptions  [\#](https://zguide.zeromq.org/docs/chapter1/\#Starting-Assumptions)

We assume you are using at least version 3.2 of ZeroMQ. We assume you are using a Linux box or something similar. We assume you can read C code, more or less, as that’s the default language for the examples. We assume that when we write constants like PUSH or SUBSCRIBE, you can imagine they are really called `ZMQ_PUSH` or `ZMQ_SUBSCRIBE` if the programming language needs it.

## Getting the Examples  [\#](https://zguide.zeromq.org/docs/chapter1/\#Getting-the-Examples)

The examples live in a public
[GitHub repository](https://github.com/imatix/zguide). The simplest way to get all the examples is to clone this repository:

```
git clone --depth=1 https://github.com/imatix/zguide.git
```

Next, browse the examples subdirectory. You’ll find examples by language. If there are examples missing in a language you use, you’re encouraged to
[submit a translation](https://zguide.zeromq.org/translate/). This is how this text became so useful, thanks to the work of many people. All examples are licensed under MIT/X11.

## Ask and Ye Shall Receive  [\#](https://zguide.zeromq.org/docs/chapter1/\#Ask-and-Ye-Shall-Receive)

So let’s start with some code. We start of course with a Hello World example. We’ll make a client and a server. The client sends “Hello” to the server, which replies with “World”. Here’s the server in C, which opens a ZeroMQ socket on port 5555, reads requests on it, and replies with “World” to each request:

hwserver: Hello World server in Ada

The example **hwserver** is missing in **Ada**:
[Contribute Translation](https://zguide.zeromq.org/translate)

hwserver: Hello World server in Basic

The example **hwserver** is missing in **Basic**:
[Contribute Translation](https://zguide.zeromq.org/translate)

hwserver: Hello World server in C

```c
//  Hello World server

#include <zmq.h>
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <assert.h>

int main (void)
{
    //  Socket to talk to clients
    void *context = zmq_ctx_new ();
    void *responder = zmq_socket (context, ZMQ_REP);
    int response = zmq_bind (responder, "tcp://*:5555");
    assert (response == 0); // Check if the response code indicates success

    while (1) {
        static const size_t kReadBufferLength = 10;
        char buffer [kReadBufferLength];
        zmq_recv (responder, buffer, kReadBufferLength, 0);
        printf ("Received Hello\n");
        sleep (1);          //  Pretend to do some 'work'
        static const char kReplyString[] = "World";
        zmq_send(responder, kReplyString, sizeof(kReplyString) - 1, 0);
    }
    return 0;
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/C/hwserver.c)

hwserver: Hello World server in C++

```c++
//
//  Hello World server in C++
//  Binds REP socket to tcp://*:5555
//  Expects "Hello" from client, replies with "World"
//
#include <zmq.hpp>
#include <string>
#include <iostream>
#ifndef _WIN32
#include <unistd.h>
#else
#include <windows.h>

#define sleep(n)	Sleep(n)
#endif

int main () {
    //  Prepare our context and socket
    static const int kNumberOfThreads = 2;
    zmq::context_t context (kNumberOfThreads);
    zmq::socket_t socket (context, zmq::socket_type::rep);
    socket.bind ("tcp://*:5555");

    while (true) {
        zmq::message_t request;

        //  Wait for next request from client
        auto result = socket.recv (request, zmq::recv_flags::none);
        assert(result.value_or(0) != 0); // Check if bytes received is non-zero
        std::cout << "Received Hello" << std::endl;

        //  Pretend to do some 'work'
        sleep(1);

        //  Send reply back to client
        constexpr std::string_view kReplyString = "World";
        zmq::message_t reply (kReplyString.length());
        memcpy (reply.data (), kReplyString.data(), kReplyString.length());
        socket.send (reply, zmq::send_flags::none);
    }
    return 0;
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/C++/hwserver.cpp)

hwserver: Hello World server in C#

```c#
﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;

using ZeroMQ;

namespace Examples
{
	static partial class Program
	{
		public static void HWServer(string[] args)
		{
			//
			// Hello World server
			//
			// Author: metadings
			//

			if (args == null || args.Length < 1)
			{
				Console.WriteLine();
				Console.WriteLine("Usage: ./{0} HWServer [Name]", AppDomain.CurrentDomain.FriendlyName);
				Console.WriteLine();
				Console.WriteLine("    Name   Your name. Default: World");
				Console.WriteLine();
				args = new string[] { "World" };
			}

			string name = args[0];

			// Create
			using (var context = new ZContext())
			using (var responder = new ZSocket(context, ZSocketType.REP))
			{
				// Bind
				responder.Bind("tcp://*:5555");

				while (true)
				{
					// Receive
					using (ZFrame request = responder.ReceiveFrame())
					{
						Console.WriteLine("Received {0}", request.ReadString());

						// Do some work
						Thread.Sleep(1);

						// Send
						responder.Send(new ZFrame(name));
					}
				}
			}
		}
	}
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/CSharp/hwserver.cs)

hwserver: Hello World server in CL

```cl
;;; -*- Mode:Lisp; Syntax:ANSI-Common-Lisp; -*-
;;;
;;;  Hello World server in Common Lisp
;;;  Binds REP socket to tcp://*:5555
;;;  Expects "Hello" from client, replies with "World"
;;;
;;; Kamil Shakirov <kamils80@gmail.com>
;;;

(defpackage #:zguide.hwserver
  (:nicknames #:hwserver)
  (:use #:cl #:zhelpers)
  (:export #:main))

(in-package :zguide.hwserver)

(defun main ()
  ;; Prepare our context and socket
  (zmq:with-context (context 1)
    (zmq:with-socket (socket context zmq:rep)
      (zmq:bind socket "tcp://*:5555")

      (loop
        (let ((request (make-instance 'zmq:msg)))
          ;; Wait for next request from client
          (zmq:recv socket request)
          (message "Received request: [~A]~%"
                   (zmq:msg-data-as-string request))

          ;; Do some 'work'
          (sleep 1)

          ;; Send reply back to client
          (let ((reply (make-instance 'zmq:msg :data "World")))
            (zmq:send socket reply))))))

  (cleanup))
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/CL/hwserver.lisp)

hwserver: Hello World server in Delphi

```delphi
program hwserver;
//
//  Hello World server
//  Binds REP socket to tcp://*:5555
//  Expects "Hello" from client, replies with "World"
//  @author Varga Balazs <bb.varga@gmail.com>
//
{$APPTYPE CONSOLE}

{$I zmq.inc}
uses
    SysUtils
  , zmq
  ;

var
  context,
  responder: Pointer;
  request,
  reply: zmq_msg_t;

begin
  context := zmq_init(1);

  //  Socket to talk to clients
  responder := zmq_socket( context, ZMQ_REP );
  zmq_bind( responder, 'tcp://*:5555' );

  while true do
  begin
    //  Wait for next request from client
    zmq_msg_init( request );
    {$ifdef zmq3}
    zmq_recvmsg( responder, request, 0 );
    {$else}
    zmq_recv( responder, request, 0 );
    {$endif}
    Writeln( 'Received Hello' );
    zmq_msg_close( request );

    //  Do some 'work'
    sleep( 1000 );

    //  Send reply back to client
    zmq_msg_init( reply );
    zmq_msg_init_size( reply, 5 );
    Move( 'World', zmq_msg_data( reply )^, 5 );
    {$ifdef zmq3}
    zmq_sendmsg( responder, reply, 0 );
    {$else}
    zmq_send( responder, reply, 0 );
    {$endif}
    zmq_msg_close( reply );

  end;

  //  We never get here but if we did, this would be how we end
  zmq_close( responder );
  zmq_term( context );
end.
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Delphi/hwserver.dpr)

hwserver: Hello World server in Erlang

```erlang
#! /usr/bin/env escript

%% Starts a local hello server.
%% Binds to tcp://localhost:5555

main(_Args) ->
    application:start(chumak),
    {ok, Socket} = chumak:socket(rep, "my-rep"),
    {ok, _Pid} = chumak:bind(Socket, tcp, "localhost", 5555),
    loop(Socket).

loop(Socket) ->
    {ok, RecvMessage} = chumak:recv(Socket),
    io:format("Received request : ~p\n", [RecvMessage]),

    timer:sleep(1000),

    chumak:send(Socket, "World"),
    loop(Socket).
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Erlang/hwserver.es)

hwserver: Hello World server in Elixir

```elixir
defmodule Hwserver do
  @moduledoc """
  Generated by erl2ex (http://github.com/dazuma/erl2ex)
  From Erlang source: (Unknown source file)
  At: 2019-12-20 13:57:24

  """

  def main(_) do
    IO.puts("hwserver starting")
    {:ok, context} = :erlzmq.context()
    {:ok, responder} = :erlzmq.socket(context, :rep)
    :ok = :erlzmq.bind(responder, 'tcp://*:5555')
    loop(responder)
    :ok = :erlzmq.close(responder)
    :ok = :erlzmq.term(context)
  end

  def loop(responder) do
    {:ok, msg} = :erlzmq.recv(responder)
    :io.format('Received ~s~n', [msg])
    :timer.sleep(1000)
    :ok = :erlzmq.send(responder, "World")
    loop(responder)
  end

end

Hwserver.main(:ok)
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Elixir/hwserver.exs)

hwserver: Hello World server in F#

```f#
(*
Hello World server
Binds REP socket to tcp://*:5555
Expects "Hello" from client, replies with "World"
*)

#r @"bin/fszmq.dll"
open fszmq

let main () =
  use context = new Context(1)

  // socket to talk to clients
  use responder = context |> Context.rep
  "tcp://*:5555" |> Socket.bind responder

  while true do
    // wait for next request from client
    responder |> Socket.recv |> ignore
    printfn "Received Hello"

    // do some work
    System.Threading.Thread.Sleep 1

    // send reply back to client
    "World"B |> Socket.send responder

  // we never get here but if we did, this would be how we end
  0 (* return code *)

main ()
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/FSharp/hwserver.fsx)

hwserver: Hello World server in Felix

```felix
// Hello World server
// Binds REP socket to tcp://*:5555
// Expects "Hello" from client, replies with "World"

open ZMQ;
println "hwserver, Felix version";

var context = zmq_init (1);

// Socket to talk to clients
var responder = context.mk_socket ZMQ_REP;
responder.bind "tcp://*:5555";
var request = #zmq_msg_t;
var reply = #zmq_msg_t;

while true do
  // Wait for next request from client
  request.init_string "Hello";
  responder.recv_msg request;
  println$ "Received Hello=" + string(request);
  request.close;

  // Do some 'work'
  Faio::sleep (sys_clock,1.0);

  // Send reply back to client
  reply.init_size 5.size;
  memcpy (zmq_msg_data reply, c"World".address, 5.size);
  responder.send_msg reply;
  reply.close;
done
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Felix/hwserver.flx)

hwserver: Hello World server in Go

```go
//
// Hello World Zeromq server
//
// Author: Aaron Raddon   github.com/araddon
// Requires: http://github.com/alecthomas/gozmq
//
package main

import (
	"fmt"
	zmq "github.com/alecthomas/gozmq"
	"time"
)

func main() {
	context, _ := zmq.NewContext()
	socket, _ := context.NewSocket(zmq.REP)
	defer context.Close()
	defer socket.Close()
	socket.Bind("tcp://*:5555")

	// Wait for messages
	for {
		msg, _ := socket.Recv(0)
		println("Received ", string(msg))

		// do some fake "work"
		time.Sleep(time.Second)

		// send reply back to client
		reply := fmt.Sprintf("World")
		socket.Send([]byte(reply), 0)
	}
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Go/hwserver.go)

hwserver: Hello World server in Haskell

```haskell
{-# LANGUAGE OverloadedStrings #-}

-- Hello World server

module Main where

import Control.Concurrent
import Control.Monad
import System.ZMQ4.Monadic

main :: IO ()
main = runZMQ $ do
    -- Socket to talk to clients
    responder <- socket Rep
    bind responder "tcp://*:5555"

    forever $ do
        buffer <- receive responder
        liftIO $ do
            putStrLn "Received Hello"
            threadDelay 1000000 -- Do some 'work'
        send responder [] "World"
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Haskell/hwserver.hs)

hwserver: Hello World server in Haxe

```haxe
package ;
import haxe.io.Bytes;
import neko.Lib;
import neko.Sys;
import org.zeromq.ZMQ;
import org.zeromq.ZMQContext;
import org.zeromq.ZMQException;
import org.zeromq.ZMQSocket;

/**
 * Hello World server in Haxe
 * Binds REP to tcp://*:5556
 * Expects "Hello" from client, replies with "World"
 * Use with HelloWorldClient.hx
 *
 */
class HelloWorldServer
{

	public static function main() {

		var context:ZMQContext = ZMQContext.instance();
		var responder:ZMQSocket = context.socket(ZMQ_REP);

		Lib.println("** HelloWorldServer (see: http://zguide.zeromq.org/page:all#Ask-and-Ye-Shall-Receive)");

		responder.setsockopt(ZMQ_LINGER, 0);
		responder.bind("tcp://*:5556");

		try {
			while (true) {
				// Wait for next request from client
				var request:Bytes = responder.recvMsg();

				trace ("Received request:" + request.toString());

				// Do some work
				Sys.sleep(1);

				// Send reply back to client
				responder.sendMsg(Bytes.ofString("World"));
			}
		} catch (e:ZMQException) {
			trace (e.toString());
		}
		responder.close();
		context.term();

	}

}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Haxe/hwserver.hx)

hwserver: Hello World server in Java

```java
package guide;

//
//  Hello World server in Java
//  Binds REP socket to tcp://*:5555
//  Expects "Hello" from client, replies with "World"
//

import org.zeromq.SocketType;
import org.zeromq.ZMQ;
import org.zeromq.ZContext;

public class hwserver
{
    public static void main(String[] args) throws Exception
    {
        try (ZContext context = new ZContext()) {
            // Socket to talk to clients
            ZMQ.Socket socket = context.createSocket(SocketType.REP);
            socket.bind("tcp://*:5555");

            while (!Thread.currentThread().isInterrupted()) {
                byte[] reply = socket.recv(0);
                System.out.println(
                    "Received " + ": [" + new String(reply, ZMQ.CHARSET) + "]"
                );

                Thread.sleep(1000); //  Do some 'work'

                String response = "world";
                socket.send(response.getBytes(ZMQ.CHARSET), 0);
            }
        }
    }
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Java/hwserver.java)

hwserver: Hello World server in Julia

```julia
#!/usr/bin/env julia

#
# Hello World server in Julia
# Binds REP socket to tcp://*:5555
# Expects "Hello" from client, replies "World"
#

using ZMQ

context = Context()
socket = Socket(context, REP)
ZMQ.bind(socket, "tcp://*:5555")

while true
    # Wait for next request from client
    message = String(ZMQ.recv(socket))
    println("Received request: $message")

    # Do some 'work'
    sleep(1)

    # Send reply back to client
    ZMQ.send(socket, "World")
end

# classy hit men always clean up when finish the job.
ZMQ.close(socket)
ZMQ.close(context)
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Julia/hwserver.jl)

hwserver: Hello World server in Lua

```lua
--
--  Hello World server
--  Binds REP socket to tcp://*:5555
--  Expects "Hello" from client, replies with "World"
--
--  Author: Robert G. Jakabosky <bobby@sharedrealm.com>
--
require"zmq"
require"zhelpers"

local context = zmq.init(1)

--  Socket to talk to clients
local socket = context:socket(zmq.REP)
socket:bind("tcp://*:5555")

while true do
    --  Wait for next request from client
    local request = socket:recv()
    print("Received Hello [" .. request .. "]")

    --  Do some 'work'
		s_sleep(1000)

    --  Send reply back to client
    socket:send("World")
end
--  We never get here but if we did, this would be how we end
socket:close()
context:term()
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Lua/hwserver.lua)

hwserver: Hello World server in Node.js

```node.js
// Hello World server
// Binds REP socket to tcp://*:5555
// Expects "Hello" from client, replies with "world"

var zmq = require('zeromq');

// socket to talk to clients
var responder = zmq.socket('rep');

responder.on('message', function(request) {
  console.log("Received request: [", request.toString(), "]");

  // do some 'work'
  setTimeout(function() {

    // send reply back to client.
    responder.send("World");
  }, 1000);
});

responder.bind('tcp://*:5555', function(err) {
  if (err) {
    console.log(err);
  } else {
    console.log("Listening on 5555...");
  }
});

process.on('SIGINT', function() {
  responder.close();
});
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Node.js/hwserver.js)

hwserver: Hello World server in Objective-C

```objective-c
//
//  Hello World server
//  Binds REP socket to tcp://*:5555
//  Expects "Hello" from client, replies with "World"
//
#import <Foundation/Foundation.h>
#import "ZMQObjc.h"

int
main(void)
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	ZMQContext *ctx = [[[ZMQContext alloc] initWithIOThreads:1U] autorelease];

	/* Get a socket to talk to clients. */
	static NSString *const kEndpoint = @"tcp://*:5555";
	ZMQSocket *responder = [ctx socketWithType:ZMQ_REP];
	BOOL didBind = [responder bindToEndpoint:kEndpoint];
	if (!didBind) {
		NSLog(@"*** Failed to bind to endpoint [%@].", kEndpoint);
		return EXIT_FAILURE;
	}

	for (;;) {
		/* Create a local pool so that autoreleased objects can be disposed of
		 * at the end of each go through the loop.
		 * Otherwise, memory usage would continue to rise
		 * until the end of the process.
		 */
		NSAutoreleasePool *localPool = [[NSAutoreleasePool alloc] init];

		/* Block waiting for next request from client. */
		NSData *request = [responder receiveDataWithFlags:0];
		NSString *text = [[[NSString alloc]\
				initWithData:request encoding:NSUTF8StringEncoding] autorelease];
		NSLog(@"Received request: %@", text);

		/* "Work" for a bit. */
		sleep(1);

		/* Send reply back to client. */
		static NSString *const kWorld = @"World";
		const char *replyCString = [kWorld UTF8String];
		const NSUInteger replyLength = [kWorld\
				lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
		NSData *reply = [NSData dataWithBytes:replyCString length:replyLength];
		[responder sendData:reply withFlags:0];

		[localPool drain];
	}

	/* Close the socket to avoid blocking in -[ZMQContext terminate]. */
	[responder close];
	/* Dispose of the context and socket. */
	[pool drain];
	return EXIT_SUCCESS;
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Objective-C/hwserver.m)

hwserver: Hello World server in ooc

The example **hwserver** is missing in **ooc**:
[Contribute Translation](https://zguide.zeromq.org/translate)

hwserver: Hello World server in Perl

```perl
# Hello World server in Perl

use strict;
use warnings;
use v5.10;

use ZMQ::FFI;
use ZMQ::FFI::Constants qw(ZMQ_REP);

# Socket to talk to clients
my $context = ZMQ::FFI->new();
my $responder = $context->socket(ZMQ_REP);
$responder->bind("tcp://*:5555");

while (1) {
    $responder->recv();
    say "Received Hello";
    sleep 1;
    $responder->send("World");
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Perl/hwserver.pl)

hwserver: Hello World server in PHP

```php
<?php
/*
 *  Hello World server
 *  Binds REP socket to tcp://*:5555
 *  Expects "Hello" from client, replies with "World"
 * @author Ian Barber <ian(dot)barber(at)gmail(dot)com>
 */

$context = new ZMQContext(1);

//  Socket to talk to clients
$responder = new ZMQSocket($context, ZMQ::SOCKET_REP);
$responder->bind("tcp://*:5555");

while (true) {
    //  Wait for next request from client
    $request = $responder->recv();
    printf ("Received request: [%s]\n", $request);

    //  Do some 'work'
    sleep (1);

    //  Send reply back to client
    $responder->send("World");
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/PHP/hwserver.php)

hwserver: Hello World server in Python

```python
#
#   Hello World server in Python
#   Binds REP socket to tcp://*:5555
#   Expects b"Hello" from client, replies with b"World"
#

import time
import zmq

context = zmq.Context()
socket = context.socket(zmq.REP)
socket.bind("tcp://*:5555")

while True:
    #  Wait for next request from client
    message = socket.recv()
    print(f"Received request: {message}")

    #  Do some 'work'
    time.sleep(1)

    #  Send reply back to client
    socket.send_string("World")
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Python/hwserver.py)

hwserver: Hello World server in Q

```q
//  Hello World server
//  Binds REP socket to tcp://*:5555
//  Expects "Hello" from client, replies with "World"
\l qzmq.q
ctx:zctx.new[]
//  Socket to talk to clients
responder:zsocket.new[ctx; zmq`REP]
port:zsocket.bind[responder; `$"tcp://*:5555"]
while[1b and not zctx.interrupted[];\
  //  Wait for next request from client\
  s:zmsg.recv responder;\
  //  Do some 'work'\
  zclock.sleep 1;\
  //  Send reply back to client\
  m1:zmsg.new[];\
  zmsg.push[m1; zframe.new["World"]];\
  zmsg.send[m1; responder]]
//  We never get here but if we did, this would how we end
zsocket.destroy[ctx; responder]
zctx.destroy[ctx]
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Q/hwserver.q)

hwserver: Hello World server in Racket

The example **hwserver** is missing in **Racket**:
[Contribute Translation](https://zguide.zeromq.org/translate)

hwserver: Hello World server in Ruby

The example **hwserver** is missing in **Ruby**:
[Contribute Translation](https://zguide.zeromq.org/translate)

hwserver: Hello World server in Rust

The example **hwserver** is missing in **Rust**:
[Contribute Translation](https://zguide.zeromq.org/translate)

hwserver: Hello World server in Scala

The example **hwserver** is missing in **Scala**:
[Contribute Translation](https://zguide.zeromq.org/translate)

hwserver: Hello World server in Tcl

The example **hwserver** is missing in **Tcl**:
[Contribute Translation](https://zguide.zeromq.org/translate)

hwserver: Hello World server in OCaml

The example **hwserver** is missing in **OCaml**:
[Contribute Translation](https://zguide.zeromq.org/translate)

C \|

C++ \|

C# \|

CL \|

Delphi \|

Erlang \|

Elixir \|

F# \|

Felix \|

Go \|

Haskell \|

Haxe \|

Java \|

Julia \|

Lua \|

Node.js \|

Objective-C \|

Perl \|

PHP \|

Python \|

Q \|

[Ada \|\\
\\
Basic \|\\
\\
ooc \|\\
\\
Racket \|\\
\\
Ruby \|\\
\\
Rust \|\\
\\
Scala \|\\
\\
Tcl \|\\
\\
OCaml](https://zguide.zeromq.org/translate)**Figure 2 - Request-Reply**

![](https://zguide.zeromq.org/images/fig2.png)

The REQ-REP socket pair is in lockstep. The client issues `
[zmq\_send()](http://api.zeromq.org/master:zmq_send)` and then `
[zmq\_recv()](http://api.zeromq.org/master:zmq_recv)`, in a loop (or once if that’s all it needs). Doing any other sequence (e.g., sending two messages in a row) will result in a return code of -1 from the `send` or `recv` call. Similarly, the service issues `
[zmq\_recv()](http://api.zeromq.org/master:zmq_recv)` and then `
[zmq\_send()](http://api.zeromq.org/master:zmq_send)` in that order, as often as it needs to.

ZeroMQ uses C as its reference language and this is the main language we’ll use for examples. If you’re reading this online, the link below the example takes you to translations into other programming languages. Let’s compare the same server in C++:

hwserver: Hello World server in C++

```c++
//
//  Hello World server in C++
//  Binds REP socket to tcp://*:5555
//  Expects "Hello" from client, replies with "World"
//
#include <zmq.hpp>
#include <string>
#include <iostream>
#ifndef _WIN32
#include <unistd.h>
#else
#include <windows.h>

#define sleep(n)	Sleep(n)
#endif

int main () {
    //  Prepare our context and socket
    static const int kNumberOfThreads = 2;
    zmq::context_t context (kNumberOfThreads);
    zmq::socket_t socket (context, zmq::socket_type::rep);
    socket.bind ("tcp://*:5555");

    while (true) {
        zmq::message_t request;

        //  Wait for next request from client
        auto result = socket.recv (request, zmq::recv_flags::none);
        assert(result.value_or(0) != 0); // Check if bytes received is non-zero
        std::cout << "Received Hello" << std::endl;

        //  Pretend to do some 'work'
        sleep(1);

        //  Send reply back to client
        constexpr std::string_view kReplyString = "World";
        zmq::message_t reply (kReplyString.length());
        memcpy (reply.data (), kReplyString.data(), kReplyString.length());
        socket.send (reply, zmq::send_flags::none);
    }
    return 0;
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/C++/hwserver.cpp)

You can see that the ZeroMQ API is similar in C and C++. In a language like PHP or Java, we can hide even more and the code becomes even easier to read:

hwserver: Hello World server in PHP

```php
<?php
/*
 *  Hello World server
 *  Binds REP socket to tcp://*:5555
 *  Expects "Hello" from client, replies with "World"
 * @author Ian Barber <ian(dot)barber(at)gmail(dot)com>
 */

$context = new ZMQContext(1);

//  Socket to talk to clients
$responder = new ZMQSocket($context, ZMQ::SOCKET_REP);
$responder->bind("tcp://*:5555");

while (true) {
    //  Wait for next request from client
    $request = $responder->recv();
    printf ("Received request: [%s]\n", $request);

    //  Do some 'work'
    sleep (1);

    //  Send reply back to client
    $responder->send("World");
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/PHP/hwserver.php)

hwserver: Hello World server in Java

```java
package guide;

//
//  Hello World server in Java
//  Binds REP socket to tcp://*:5555
//  Expects "Hello" from client, replies with "World"
//

import org.zeromq.SocketType;
import org.zeromq.ZMQ;
import org.zeromq.ZContext;

public class hwserver
{
    public static void main(String[] args) throws Exception
    {
        try (ZContext context = new ZContext()) {
            // Socket to talk to clients
            ZMQ.Socket socket = context.createSocket(SocketType.REP);
            socket.bind("tcp://*:5555");

            while (!Thread.currentThread().isInterrupted()) {
                byte[] reply = socket.recv(0);
                System.out.println(
                    "Received " + ": [" + new String(reply, ZMQ.CHARSET) + "]"
                );

                Thread.sleep(1000); //  Do some 'work'

                String response = "world";
                socket.send(response.getBytes(ZMQ.CHARSET), 0);
            }
        }
    }
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Java/hwserver.java)

The server in other languages:

hwserver: Hello World server in Ada

The example **hwserver** is missing in **Ada**:
[Contribute Translation](https://zguide.zeromq.org/translate)

hwserver: Hello World server in Basic

The example **hwserver** is missing in **Basic**:
[Contribute Translation](https://zguide.zeromq.org/translate)

hwserver: Hello World server in C

```c
//  Hello World server

#include <zmq.h>
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <assert.h>

int main (void)
{
    //  Socket to talk to clients
    void *context = zmq_ctx_new ();
    void *responder = zmq_socket (context, ZMQ_REP);
    int response = zmq_bind (responder, "tcp://*:5555");
    assert (response == 0); // Check if the response code indicates success

    while (1) {
        static const size_t kReadBufferLength = 10;
        char buffer [kReadBufferLength];
        zmq_recv (responder, buffer, kReadBufferLength, 0);
        printf ("Received Hello\n");
        sleep (1);          //  Pretend to do some 'work'
        static const char kReplyString[] = "World";
        zmq_send(responder, kReplyString, sizeof(kReplyString) - 1, 0);
    }
    return 0;
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/C/hwserver.c)

hwserver: Hello World server in C++

```c++
//
//  Hello World server in C++
//  Binds REP socket to tcp://*:5555
//  Expects "Hello" from client, replies with "World"
//
#include <zmq.hpp>
#include <string>
#include <iostream>
#ifndef _WIN32
#include <unistd.h>
#else
#include <windows.h>

#define sleep(n)	Sleep(n)
#endif

int main () {
    //  Prepare our context and socket
    static const int kNumberOfThreads = 2;
    zmq::context_t context (kNumberOfThreads);
    zmq::socket_t socket (context, zmq::socket_type::rep);
    socket.bind ("tcp://*:5555");

    while (true) {
        zmq::message_t request;

        //  Wait for next request from client
        auto result = socket.recv (request, zmq::recv_flags::none);
        assert(result.value_or(0) != 0); // Check if bytes received is non-zero
        std::cout << "Received Hello" << std::endl;

        //  Pretend to do some 'work'
        sleep(1);

        //  Send reply back to client
        constexpr std::string_view kReplyString = "World";
        zmq::message_t reply (kReplyString.length());
        memcpy (reply.data (), kReplyString.data(), kReplyString.length());
        socket.send (reply, zmq::send_flags::none);
    }
    return 0;
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/C++/hwserver.cpp)

hwserver: Hello World server in C#

```c#
﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;

using ZeroMQ;

namespace Examples
{
	static partial class Program
	{
		public static void HWServer(string[] args)
		{
			//
			// Hello World server
			//
			// Author: metadings
			//

			if (args == null || args.Length < 1)
			{
				Console.WriteLine();
				Console.WriteLine("Usage: ./{0} HWServer [Name]", AppDomain.CurrentDomain.FriendlyName);
				Console.WriteLine();
				Console.WriteLine("    Name   Your name. Default: World");
				Console.WriteLine();
				args = new string[] { "World" };
			}

			string name = args[0];

			// Create
			using (var context = new ZContext())
			using (var responder = new ZSocket(context, ZSocketType.REP))
			{
				// Bind
				responder.Bind("tcp://*:5555");

				while (true)
				{
					// Receive
					using (ZFrame request = responder.ReceiveFrame())
					{
						Console.WriteLine("Received {0}", request.ReadString());

						// Do some work
						Thread.Sleep(1);

						// Send
						responder.Send(new ZFrame(name));
					}
				}
			}
		}
	}
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/CSharp/hwserver.cs)

hwserver: Hello World server in CL

```cl
;;; -*- Mode:Lisp; Syntax:ANSI-Common-Lisp; -*-
;;;
;;;  Hello World server in Common Lisp
;;;  Binds REP socket to tcp://*:5555
;;;  Expects "Hello" from client, replies with "World"
;;;
;;; Kamil Shakirov <kamils80@gmail.com>
;;;

(defpackage #:zguide.hwserver
  (:nicknames #:hwserver)
  (:use #:cl #:zhelpers)
  (:export #:main))

(in-package :zguide.hwserver)

(defun main ()
  ;; Prepare our context and socket
  (zmq:with-context (context 1)
    (zmq:with-socket (socket context zmq:rep)
      (zmq:bind socket "tcp://*:5555")

      (loop
        (let ((request (make-instance 'zmq:msg)))
          ;; Wait for next request from client
          (zmq:recv socket request)
          (message "Received request: [~A]~%"
                   (zmq:msg-data-as-string request))

          ;; Do some 'work'
          (sleep 1)

          ;; Send reply back to client
          (let ((reply (make-instance 'zmq:msg :data "World")))
            (zmq:send socket reply))))))

  (cleanup))
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/CL/hwserver.lisp)

hwserver: Hello World server in Delphi

```delphi
program hwserver;
//
//  Hello World server
//  Binds REP socket to tcp://*:5555
//  Expects "Hello" from client, replies with "World"
//  @author Varga Balazs <bb.varga@gmail.com>
//
{$APPTYPE CONSOLE}

{$I zmq.inc}
uses
    SysUtils
  , zmq
  ;

var
  context,
  responder: Pointer;
  request,
  reply: zmq_msg_t;

begin
  context := zmq_init(1);

  //  Socket to talk to clients
  responder := zmq_socket( context, ZMQ_REP );
  zmq_bind( responder, 'tcp://*:5555' );

  while true do
  begin
    //  Wait for next request from client
    zmq_msg_init( request );
    {$ifdef zmq3}
    zmq_recvmsg( responder, request, 0 );
    {$else}
    zmq_recv( responder, request, 0 );
    {$endif}
    Writeln( 'Received Hello' );
    zmq_msg_close( request );

    //  Do some 'work'
    sleep( 1000 );

    //  Send reply back to client
    zmq_msg_init( reply );
    zmq_msg_init_size( reply, 5 );
    Move( 'World', zmq_msg_data( reply )^, 5 );
    {$ifdef zmq3}
    zmq_sendmsg( responder, reply, 0 );
    {$else}
    zmq_send( responder, reply, 0 );
    {$endif}
    zmq_msg_close( reply );

  end;

  //  We never get here but if we did, this would be how we end
  zmq_close( responder );
  zmq_term( context );
end.
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Delphi/hwserver.dpr)

hwserver: Hello World server in Erlang

```erlang
#! /usr/bin/env escript

%% Starts a local hello server.
%% Binds to tcp://localhost:5555

main(_Args) ->
    application:start(chumak),
    {ok, Socket} = chumak:socket(rep, "my-rep"),
    {ok, _Pid} = chumak:bind(Socket, tcp, "localhost", 5555),
    loop(Socket).

loop(Socket) ->
    {ok, RecvMessage} = chumak:recv(Socket),
    io:format("Received request : ~p\n", [RecvMessage]),

    timer:sleep(1000),

    chumak:send(Socket, "World"),
    loop(Socket).
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Erlang/hwserver.es)

hwserver: Hello World server in Elixir

```elixir
defmodule Hwserver do
  @moduledoc """
  Generated by erl2ex (http://github.com/dazuma/erl2ex)
  From Erlang source: (Unknown source file)
  At: 2019-12-20 13:57:24

  """

  def main(_) do
    IO.puts("hwserver starting")
    {:ok, context} = :erlzmq.context()
    {:ok, responder} = :erlzmq.socket(context, :rep)
    :ok = :erlzmq.bind(responder, 'tcp://*:5555')
    loop(responder)
    :ok = :erlzmq.close(responder)
    :ok = :erlzmq.term(context)
  end

  def loop(responder) do
    {:ok, msg} = :erlzmq.recv(responder)
    :io.format('Received ~s~n', [msg])
    :timer.sleep(1000)
    :ok = :erlzmq.send(responder, "World")
    loop(responder)
  end

end

Hwserver.main(:ok)
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Elixir/hwserver.exs)

hwserver: Hello World server in F#

```f#
(*
Hello World server
Binds REP socket to tcp://*:5555
Expects "Hello" from client, replies with "World"
*)

#r @"bin/fszmq.dll"
open fszmq

let main () =
  use context = new Context(1)

  // socket to talk to clients
  use responder = context |> Context.rep
  "tcp://*:5555" |> Socket.bind responder

  while true do
    // wait for next request from client
    responder |> Socket.recv |> ignore
    printfn "Received Hello"

    // do some work
    System.Threading.Thread.Sleep 1

    // send reply back to client
    "World"B |> Socket.send responder

  // we never get here but if we did, this would be how we end
  0 (* return code *)

main ()
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/FSharp/hwserver.fsx)

hwserver: Hello World server in Felix

```felix
// Hello World server
// Binds REP socket to tcp://*:5555
// Expects "Hello" from client, replies with "World"

open ZMQ;
println "hwserver, Felix version";

var context = zmq_init (1);

// Socket to talk to clients
var responder = context.mk_socket ZMQ_REP;
responder.bind "tcp://*:5555";
var request = #zmq_msg_t;
var reply = #zmq_msg_t;

while true do
  // Wait for next request from client
  request.init_string "Hello";
  responder.recv_msg request;
  println$ "Received Hello=" + string(request);
  request.close;

  // Do some 'work'
  Faio::sleep (sys_clock,1.0);

  // Send reply back to client
  reply.init_size 5.size;
  memcpy (zmq_msg_data reply, c"World".address, 5.size);
  responder.send_msg reply;
  reply.close;
done
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Felix/hwserver.flx)

hwserver: Hello World server in Go

```go
//
// Hello World Zeromq server
//
// Author: Aaron Raddon   github.com/araddon
// Requires: http://github.com/alecthomas/gozmq
//
package main

import (
	"fmt"
	zmq "github.com/alecthomas/gozmq"
	"time"
)

func main() {
	context, _ := zmq.NewContext()
	socket, _ := context.NewSocket(zmq.REP)
	defer context.Close()
	defer socket.Close()
	socket.Bind("tcp://*:5555")

	// Wait for messages
	for {
		msg, _ := socket.Recv(0)
		println("Received ", string(msg))

		// do some fake "work"
		time.Sleep(time.Second)

		// send reply back to client
		reply := fmt.Sprintf("World")
		socket.Send([]byte(reply), 0)
	}
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Go/hwserver.go)

hwserver: Hello World server in Haskell

```haskell
{-# LANGUAGE OverloadedStrings #-}

-- Hello World server

module Main where

import Control.Concurrent
import Control.Monad
import System.ZMQ4.Monadic

main :: IO ()
main = runZMQ $ do
    -- Socket to talk to clients
    responder <- socket Rep
    bind responder "tcp://*:5555"

    forever $ do
        buffer <- receive responder
        liftIO $ do
            putStrLn "Received Hello"
            threadDelay 1000000 -- Do some 'work'
        send responder [] "World"
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Haskell/hwserver.hs)

hwserver: Hello World server in Haxe

```haxe
package ;
import haxe.io.Bytes;
import neko.Lib;
import neko.Sys;
import org.zeromq.ZMQ;
import org.zeromq.ZMQContext;
import org.zeromq.ZMQException;
import org.zeromq.ZMQSocket;

/**
 * Hello World server in Haxe
 * Binds REP to tcp://*:5556
 * Expects "Hello" from client, replies with "World"
 * Use with HelloWorldClient.hx
 *
 */
class HelloWorldServer
{

	public static function main() {

		var context:ZMQContext = ZMQContext.instance();
		var responder:ZMQSocket = context.socket(ZMQ_REP);

		Lib.println("** HelloWorldServer (see: http://zguide.zeromq.org/page:all#Ask-and-Ye-Shall-Receive)");

		responder.setsockopt(ZMQ_LINGER, 0);
		responder.bind("tcp://*:5556");

		try {
			while (true) {
				// Wait for next request from client
				var request:Bytes = responder.recvMsg();

				trace ("Received request:" + request.toString());

				// Do some work
				Sys.sleep(1);

				// Send reply back to client
				responder.sendMsg(Bytes.ofString("World"));
			}
		} catch (e:ZMQException) {
			trace (e.toString());
		}
		responder.close();
		context.term();

	}

}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Haxe/hwserver.hx)

hwserver: Hello World server in Java

```java
package guide;

//
//  Hello World server in Java
//  Binds REP socket to tcp://*:5555
//  Expects "Hello" from client, replies with "World"
//

import org.zeromq.SocketType;
import org.zeromq.ZMQ;
import org.zeromq.ZContext;

public class hwserver
{
    public static void main(String[] args) throws Exception
    {
        try (ZContext context = new ZContext()) {
            // Socket to talk to clients
            ZMQ.Socket socket = context.createSocket(SocketType.REP);
            socket.bind("tcp://*:5555");

            while (!Thread.currentThread().isInterrupted()) {
                byte[] reply = socket.recv(0);
                System.out.println(
                    "Received " + ": [" + new String(reply, ZMQ.CHARSET) + "]"
                );

                Thread.sleep(1000); //  Do some 'work'

                String response = "world";
                socket.send(response.getBytes(ZMQ.CHARSET), 0);
            }
        }
    }
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Java/hwserver.java)

hwserver: Hello World server in Julia

```julia
#!/usr/bin/env julia

#
# Hello World server in Julia
# Binds REP socket to tcp://*:5555
# Expects "Hello" from client, replies "World"
#

using ZMQ

context = Context()
socket = Socket(context, REP)
ZMQ.bind(socket, "tcp://*:5555")

while true
    # Wait for next request from client
    message = String(ZMQ.recv(socket))
    println("Received request: $message")

    # Do some 'work'
    sleep(1)

    # Send reply back to client
    ZMQ.send(socket, "World")
end

# classy hit men always clean up when finish the job.
ZMQ.close(socket)
ZMQ.close(context)
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Julia/hwserver.jl)

hwserver: Hello World server in Lua

```lua
--
--  Hello World server
--  Binds REP socket to tcp://*:5555
--  Expects "Hello" from client, replies with "World"
--
--  Author: Robert G. Jakabosky <bobby@sharedrealm.com>
--
require"zmq"
require"zhelpers"

local context = zmq.init(1)

--  Socket to talk to clients
local socket = context:socket(zmq.REP)
socket:bind("tcp://*:5555")

while true do
    --  Wait for next request from client
    local request = socket:recv()
    print("Received Hello [" .. request .. "]")

    --  Do some 'work'
		s_sleep(1000)

    --  Send reply back to client
    socket:send("World")
end
--  We never get here but if we did, this would be how we end
socket:close()
context:term()
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Lua/hwserver.lua)

hwserver: Hello World server in Node.js

```node.js
// Hello World server
// Binds REP socket to tcp://*:5555
// Expects "Hello" from client, replies with "world"

var zmq = require('zeromq');

// socket to talk to clients
var responder = zmq.socket('rep');

responder.on('message', function(request) {
  console.log("Received request: [", request.toString(), "]");

  // do some 'work'
  setTimeout(function() {

    // send reply back to client.
    responder.send("World");
  }, 1000);
});

responder.bind('tcp://*:5555', function(err) {
  if (err) {
    console.log(err);
  } else {
    console.log("Listening on 5555...");
  }
});

process.on('SIGINT', function() {
  responder.close();
});
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Node.js/hwserver.js)

hwserver: Hello World server in Objective-C

```objective-c
//
//  Hello World server
//  Binds REP socket to tcp://*:5555
//  Expects "Hello" from client, replies with "World"
//
#import <Foundation/Foundation.h>
#import "ZMQObjc.h"

int
main(void)
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	ZMQContext *ctx = [[[ZMQContext alloc] initWithIOThreads:1U] autorelease];

	/* Get a socket to talk to clients. */
	static NSString *const kEndpoint = @"tcp://*:5555";
	ZMQSocket *responder = [ctx socketWithType:ZMQ_REP];
	BOOL didBind = [responder bindToEndpoint:kEndpoint];
	if (!didBind) {
		NSLog(@"*** Failed to bind to endpoint [%@].", kEndpoint);
		return EXIT_FAILURE;
	}

	for (;;) {
		/* Create a local pool so that autoreleased objects can be disposed of
		 * at the end of each go through the loop.
		 * Otherwise, memory usage would continue to rise
		 * until the end of the process.
		 */
		NSAutoreleasePool *localPool = [[NSAutoreleasePool alloc] init];

		/* Block waiting for next request from client. */
		NSData *request = [responder receiveDataWithFlags:0];
		NSString *text = [[[NSString alloc]\
				initWithData:request encoding:NSUTF8StringEncoding] autorelease];
		NSLog(@"Received request: %@", text);

		/* "Work" for a bit. */
		sleep(1);

		/* Send reply back to client. */
		static NSString *const kWorld = @"World";
		const char *replyCString = [kWorld UTF8String];
		const NSUInteger replyLength = [kWorld\
				lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
		NSData *reply = [NSData dataWithBytes:replyCString length:replyLength];
		[responder sendData:reply withFlags:0];

		[localPool drain];
	}

	/* Close the socket to avoid blocking in -[ZMQContext terminate]. */
	[responder close];
	/* Dispose of the context and socket. */
	[pool drain];
	return EXIT_SUCCESS;
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Objective-C/hwserver.m)

hwserver: Hello World server in ooc

The example **hwserver** is missing in **ooc**:
[Contribute Translation](https://zguide.zeromq.org/translate)

hwserver: Hello World server in Perl

```perl
# Hello World server in Perl

use strict;
use warnings;
use v5.10;

use ZMQ::FFI;
use ZMQ::FFI::Constants qw(ZMQ_REP);

# Socket to talk to clients
my $context = ZMQ::FFI->new();
my $responder = $context->socket(ZMQ_REP);
$responder->bind("tcp://*:5555");

while (1) {
    $responder->recv();
    say "Received Hello";
    sleep 1;
    $responder->send("World");
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Perl/hwserver.pl)

hwserver: Hello World server in PHP

```php
<?php
/*
 *  Hello World server
 *  Binds REP socket to tcp://*:5555
 *  Expects "Hello" from client, replies with "World"
 * @author Ian Barber <ian(dot)barber(at)gmail(dot)com>
 */

$context = new ZMQContext(1);

//  Socket to talk to clients
$responder = new ZMQSocket($context, ZMQ::SOCKET_REP);
$responder->bind("tcp://*:5555");

while (true) {
    //  Wait for next request from client
    $request = $responder->recv();
    printf ("Received request: [%s]\n", $request);

    //  Do some 'work'
    sleep (1);

    //  Send reply back to client
    $responder->send("World");
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/PHP/hwserver.php)

hwserver: Hello World server in Python

```python
#
#   Hello World server in Python
#   Binds REP socket to tcp://*:5555
#   Expects b"Hello" from client, replies with b"World"
#

import time
import zmq

context = zmq.Context()
socket = context.socket(zmq.REP)
socket.bind("tcp://*:5555")

while True:
    #  Wait for next request from client
    message = socket.recv()
    print(f"Received request: {message}")

    #  Do some 'work'
    time.sleep(1)

    #  Send reply back to client
    socket.send_string("World")
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Python/hwserver.py)

hwserver: Hello World server in Q

```q
//  Hello World server
//  Binds REP socket to tcp://*:5555
//  Expects "Hello" from client, replies with "World"
\l qzmq.q
ctx:zctx.new[]
//  Socket to talk to clients
responder:zsocket.new[ctx; zmq`REP]
port:zsocket.bind[responder; `$"tcp://*:5555"]
while[1b and not zctx.interrupted[];\
  //  Wait for next request from client\
  s:zmsg.recv responder;\
  //  Do some 'work'\
  zclock.sleep 1;\
  //  Send reply back to client\
  m1:zmsg.new[];\
  zmsg.push[m1; zframe.new["World"]];\
  zmsg.send[m1; responder]]
//  We never get here but if we did, this would how we end
zsocket.destroy[ctx; responder]
zctx.destroy[ctx]
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Q/hwserver.q)

hwserver: Hello World server in Racket

The example **hwserver** is missing in **Racket**:
[Contribute Translation](https://zguide.zeromq.org/translate)

hwserver: Hello World server in Ruby

The example **hwserver** is missing in **Ruby**:
[Contribute Translation](https://zguide.zeromq.org/translate)

hwserver: Hello World server in Rust

The example **hwserver** is missing in **Rust**:
[Contribute Translation](https://zguide.zeromq.org/translate)

hwserver: Hello World server in Scala

The example **hwserver** is missing in **Scala**:
[Contribute Translation](https://zguide.zeromq.org/translate)

hwserver: Hello World server in Tcl

The example **hwserver** is missing in **Tcl**:
[Contribute Translation](https://zguide.zeromq.org/translate)

hwserver: Hello World server in OCaml

The example **hwserver** is missing in **OCaml**:
[Contribute Translation](https://zguide.zeromq.org/translate)

C \|

C++ \|

C# \|

CL \|

Delphi \|

Erlang \|

Elixir \|

F# \|

Felix \|

Go \|

Haskell \|

Haxe \|

Java \|

Julia \|

Lua \|

Node.js \|

Objective-C \|

Perl \|

PHP \|

Python \|

Q \|

[Ada \|\\
\\
Basic \|\\
\\
ooc \|\\
\\
Racket \|\\
\\
Ruby \|\\
\\
Rust \|\\
\\
Scala \|\\
\\
Tcl \|\\
\\
OCaml](https://zguide.zeromq.org/translate)

Here’s the client code:

hwclient: Hello World client in Ada

The example **hwclient** is missing in **Ada**:
[Contribute Translation](https://zguide.zeromq.org/translate)

hwclient: Hello World client in Basic

The example **hwclient** is missing in **Basic**:
[Contribute Translation](https://zguide.zeromq.org/translate)

hwclient: Hello World client in C

```c
//  Hello World client
#include <zmq.h>
#include <string.h>
#include <stdio.h>
#include <unistd.h>

int main (void)
{
    printf ("Connecting to hello world server...\n");
    void *context = zmq_ctx_new ();
    void *requester = zmq_socket (context, ZMQ_REQ);
    zmq_connect (requester, "tcp://localhost:5555");

    int request_nbr;
    for (request_nbr = 0; request_nbr != 10; request_nbr++) {
        char buffer [10];
        printf ("Sending Hello %d...\n", request_nbr);
        zmq_send (requester, "Hello", 5, 0);
        zmq_recv (requester, buffer, 10, 0);
        printf ("Received World %d\n", request_nbr);
    }
    zmq_close (requester);
    zmq_ctx_destroy (context);
    return 0;
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/C/hwclient.c)

hwclient: Hello World client in C++

```c++
//
//  Hello World client in C++
//  Connects REQ socket to tcp://localhost:5555
//  Sends "Hello" to server, expects "World" back
//
#include <zmq.hpp>
#include <string>
#include <iostream>

int main ()
{
    //  Prepare our context and socket
    zmq::context_t context (1);
    zmq::socket_t socket (context, zmq::socket_type::req);

    std::cout << "Connecting to hello world server..." << std::endl;
    socket.connect ("tcp://localhost:5555");

    //  Do 10 requests, waiting each time for a response
    for (int request_nbr = 0; request_nbr != 10; request_nbr++) {
        zmq::message_t request (5);
        memcpy (request.data (), "Hello", 5);
        std::cout << "Sending Hello " << request_nbr << "..." << std::endl;
        socket.send (request, zmq::send_flags::none);

        //  Get the reply.
        zmq::message_t reply;
        socket.recv (reply, zmq::recv_flags::none);
        std::cout << "Received World " << request_nbr << std::endl;
    }
    return 0;
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/C++/hwclient.cpp)

hwclient: Hello World client in C#

```c#
﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;

using ZeroMQ;

namespace Examples
{
	static partial class Program
	{
		public static void HWClient(string[] args)
		{
			//
			// Hello World client
			//
			// Author: metadings
			//

			if (args == null || args.Length < 1)
			{
				Console.WriteLine();
				Console.WriteLine("Usage: ./{0} HWClient [Endpoint]", AppDomain.CurrentDomain.FriendlyName);
				Console.WriteLine();
				Console.WriteLine("    Endpoint  Where HWClient should connect to.");
				Console.WriteLine("              Default is tcp://127.0.0.1:5555");
				Console.WriteLine();
				args = new string[] { "tcp://127.0.0.1:5555" };
			}

			string endpoint = args[0];

			// Create
			using (var context = new ZContext())
			using (var requester = new ZSocket(context, ZSocketType.REQ))
			{
				// Connect
				requester.Connect(endpoint);

				for (int n = 0; n < 10; ++n)
				{
					string requestText = "Hello";
					Console.Write("Sending {0}...", requestText);

					// Send
					requester.Send(new ZFrame(requestText));

					// Receive
					using (ZFrame reply = requester.ReceiveFrame())
					{
						Console.WriteLine(" Received: {0} {1}!", requestText, reply.ReadString());
					}
				}
			}
		}
	}
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/CSharp/hwclient.cs)

hwclient: Hello World client in CL

```cl
;;; -*- Mode:Lisp; Syntax:ANSI-Common-Lisp; -*-
;;;
;;;  Hello World client in Common Lisp
;;;  Connects REQ socket to tcp://localhost:5555
;;;  Sends "Hello" to server, expects "World" back
;;;
;;; Kamil Shakirov <kamils80@gmail.com>
;;;

(defpackage #:zguide.hwclient
  (:nicknames #:hwclient)
  (:use #:cl #:zhelpers)
  (:export #:main))

(in-package :zguide.hwclient)

(defun main ()
  ;; Prepare our context and socket
  (zmq:with-context (context 1)
    (zmq:with-socket (socket context zmq:req)
      (message "Connecting to hello world server...~%")
      (zmq:connect socket "tcp://localhost:5555")

      ;; Do 10 requests, waiting each time for a response
      (dotimes (request-nbr 10)
        (let ((request (make-instance 'zmq:msg :data "Hello")))
          (message "Sending request ~D...~%" request-nbr)
          (zmq:send socket request))

        ;; Get the reply
        (let ((response (make-instance 'zmq:msg)))
          (zmq:recv socket response)
          (message "Received reply ~D: [~A]~%"
                   request-nbr (zmq:msg-data-as-string response))))))

  (cleanup))
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/CL/hwclient.lisp)

hwclient: Hello World client in Delphi

```delphi
program hwclient;
//
//  Hello World client
//  Connects REQ socket to tcp://localhost:5555
//  Sends "Hello" to server, expects "World" back
//  @author Varga Balazs <bb.varga@gmail.com>
//
{$APPTYPE CONSOLE}

uses
    SysUtils
  , zmqapi
  ;

var
  context: TZMQContext;
  requester: TZMQSocket;
  i: Integer;
  sMsg: Utf8String;
begin
  context := TZMQContext.Create;

  //  Socket to talk to server
  Writeln('Connecting to hello world server...');
  requester := Context.Socket( stReq );
  requester.connect( 'tcp://localhost:5555' );

  for i := 0 to 9 do
  begin
    sMsg := 'Hello';
    Writeln( Format( 'Sending %s %d',[ sMsg, i ] ));
    requester.send( sMsg );
    requester.recv( sMsg );
    Writeln( Format( 'Received %s %d', [ sMsg, i ] ) );
  end;

  sleep(2000);
  requester.Free;
  context.Free;
end.
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Delphi/hwclient.dpr)

hwclient: Hello World client in Erlang

```erlang
#! /usr/bin/env escript

%%
%% "Hello world" client example.
%% Connects to tcp://localhost:5555
%% Sends <<"Hello">> to server and prints the response
%%

main(_Args) ->
    application:start(chumak),
    {ok, Socket} = chumak:socket(req, "my-req"),
    {ok, _Pid} = chumak:connect(Socket, tcp, "localhost", 5555),
    loop(Socket).

loop(Socket) ->
    chumak:send(Socket, "Hello"),
    {ok, RecvMessage} = chumak:recv(Socket),
    io:format("Recv Reply: ~p\n", [RecvMessage]),
    loop(Socket).
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Erlang/hwclient.es)

hwclient: Hello World client in Elixir

```elixir
defmodule Hwclient do
  @moduledoc """
  Generated by erl2ex (http://github.com/dazuma/erl2ex)
  From Erlang source: (Unknown source file)
  At: 2019-12-20 13:57:23

  """

  def main(_) do
    {:ok, context} = :erlzmq.context()
    :io.format('Connecting to hello world server...~n')
    {:ok, requester} = :erlzmq.socket(context, :req)
    :ok = :erlzmq.connect(requester, 'tcp://localhost:5555')
    :lists.foreach(fn n ->
      :io.format('Sending Hello ~b...~n', [n])
      :ok = :erlzmq.send(requester, "Hello")
      {:ok, reply} = :erlzmq.recv(requester)
      :io.format('Received ~s ~b~n', [reply, n])
    end, :lists.seq(1, 10))
    :ok = :erlzmq.close(requester)
    :ok = :erlzmq.term(context)
  end

end

Hwclient.main(:ok)
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Elixir/hwclient.exs)

hwclient: Hello World client in F#

```f#
(*
Hello World client
Connects REQ socket to tcp://localhost:5555
Sends "Hello" to server, expects "World" back
*)

#r @"bin/fszmq.dll"
open fszmq

let main () =
  use context = new Context(1)

  // socket to talk to server
  printfn "Connecting to hello world server..."
  use requester = context |> Context.req
  "tcp://localhost:5555" |> Socket.connect requester

  for request_nbr in 0 .. 99 do
    printfn "Sending Hello %d..." request_nbr
    "Hello"B |> Socket.send requester

    requester |> Socket.recv |> ignore
    printfn "Received World %d" request_nbr

  0 (* RETURN CODE *)

main ()
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/FSharp/hwclient.fsx)

hwclient: Hello World client in Felix

```felix
// Hello World client
// Connects REQ socket to tcp://localhost:5555
// Sends "Hello" to server, expects "World" back

open ZMQ;
println "hwclient, Felix version";

var context = zmq_init 1;

    // Socket to talk to server
    println "Connecting to hello world server";

var requester = context.mk_socket ZMQ_REQ;

requester.connect "tcp://localhost:5555";
var request = #zmq_msg_t;
var reply = #zmq_msg_t;

for var request_nbr in 0 upto 9 do
  request.init_size 5.size;
  memcpy (zmq_msg_data request, c"Hello".address, 5.size);
  print$ f"Sending Hello %d\n" request_nbr;
  requester.send_msg request;
  request.close;
  reply.init_size 5.size;
  requester.recv_msg reply;
  println$ f"Received World %d=%S" (request_nbr, reply.string);
  reply.close;
done
requester.close;
context.term;
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Felix/hwclient.flx)

hwclient: Hello World client in Go

```go
//
// Hello World Zeromq Client
//
// Author: Aaron Raddon   github.com/araddon
// Requires: http://github.com/alecthomas/gozmq
//
package main

import (
	"fmt"
	zmq "github.com/alecthomas/gozmq"
)

func main() {
	context, _ := zmq.NewContext()
	socket, _ := context.NewSocket(zmq.REQ)
	defer context.Close()
	defer socket.Close()

	fmt.Printf("Connecting to hello world server...")
	socket.Connect("tcp://localhost:5555")

	for i := 0; i < 10; i++ {
		// send hello
		msg := fmt.Sprintf("Hello %d", i)
		socket.Send([]byte(msg), 0)
		println("Sending ", msg)

		// Wait for reply:
		reply, _ := socket.Recv(0)
		println("Received ", string(reply))
	}
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Go/hwclient.go)

hwclient: Hello World client in Haskell

```haskell
{-# LANGUAGE OverloadedStrings #-}

-- Hello World client

module Main where

import Control.Monad
import System.ZMQ4.Monadic

main :: IO ()
main = runZMQ $ do
    liftIO $ putStrLn "Connecting to hello world server..."

    requester <- socket Req
    connect requester "tcp://localhost:5555"

    forM_ [1..10] $ \i -> do
        liftIO . putStrLn $ "Sending Hello " ++ show i ++ "..."
        send requester [] "Hello"
        _ <- receive requester
        liftIO . putStrLn $ "Received World " ++ show i
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Haskell/hwclient.hs)

hwclient: Hello World client in Haxe

```haxe
package ;
import haxe.io.Bytes;
import neko.Lib;
import neko.Sys;

import org.zeromq.ZMQ;
import org.zeromq.ZMQContext;
import org.zeromq.ZMQSocket;

/**
 * Hello World client in Haxe.
 * Use with HelloWorldServer.hx and MTServer.hx
 */
class HelloWorldClient
{

	public static function main() {
		var context:ZMQContext = ZMQContext.instance();
		var socket:ZMQSocket = context.socket(ZMQ_REQ);

		Lib.println("** HelloWorldClient (see: http://zguide.zeromq.org/page:all#Ask-and-Ye-Shall-Receive)");

		trace ("Connecting to hello world server...");
		socket.connect ("tcp://localhost:5556");

		// Do 10 requests, waiting each time for a response
		for (i in 0...10) {
			var requestString = "Hello ";

			// Send the message
			trace ("Sending request " + i + " ...");
			socket.sendMsg(Bytes.ofString(requestString));

			// Wait for the reply
			var msg:Bytes = socket.recvMsg();

			trace ("Received reply " + i + ": [" + msg.toString() + "]");
		}

		// Shut down socket and context
		socket.close();
		context.term();
	}
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Haxe/hwclient.hx)

hwclient: Hello World client in Java

```java
package guide;

//
//  Hello World client in Java
//  Connects REQ socket to tcp://localhost:5555
//  Sends "Hello" to server, expects "World" back
//

import org.zeromq.SocketType;
import org.zeromq.ZMQ;
import org.zeromq.ZContext;

public class hwclient
{
    public static void main(String[] args)
    {
        try (ZContext context = new ZContext()) {
            //  Socket to talk to server
            System.out.println("Connecting to hello world server");

            ZMQ.Socket socket = context.createSocket(SocketType.REQ);
            socket.connect("tcp://localhost:5555");

            for (int requestNbr = 0; requestNbr != 10; requestNbr++) {
                String request = "Hello";
                System.out.println("Sending Hello " + requestNbr);
                socket.send(request.getBytes(ZMQ.CHARSET), 0);

                byte[] reply = socket.recv(0);
                System.out.println(
                    "Received " + new String(reply, ZMQ.CHARSET) + " " +
                    requestNbr
                );
            }
        }
    }
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Java/hwclient.java)

hwclient: Hello World client in Julia

```julia
#!/usr/bin/env julia

#
# Hello World client in Julia
# Connects REQ socket to tcp://localhost:5555
# Sends "Hello" to server, expects "World" back
#

using ZMQ

context = Context()

# Socket to talk to server
println("Connecting to hello world server...")
socket = Socket(context, REQ)
ZMQ.connect(socket, "tcp://localhost:5555")

for request in 1:10
    println("Sending request $request ...")
    ZMQ.send(socket, "Hello")

    # Get the reply.
    message = String(ZMQ.recv(socket))
    println("Received reply $request [ $message ]")
end

# Making a clean exit.
ZMQ.close(socket)
ZMQ.close(context)
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Julia/hwclient.jl)

hwclient: Hello World client in Lua

```lua
--
--  Hello World client
--  Connects REQ socket to tcp://localhost:5555
--  Sends "Hello" to server, expects "World" back
--
--  Author: Robert G. Jakabosky <bobby@sharedrealm.com>
--
require"zmq"

local context = zmq.init(1)

--  Socket to talk to server
print("Connecting to hello world server...")
local socket = context:socket(zmq.REQ)
socket:connect("tcp://localhost:5555")

for n=1,10 do
    print("Sending Hello " .. n .. " ...")
    socket:send("Hello")

    local reply = socket:recv()
    print("Received World " ..  n .. " [" .. reply .. "]")
end
socket:close()
context:term()
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Lua/hwclient.lua)

hwclient: Hello World client in Node.js

```node.js
// Hello World client
// Connects REQ socket to tcp://localhost:5555
// Sends "Hello" to server.

var zmq = require('zeromq');

// socket to talk to server
console.log("Connecting to hello world server...");
var requester = zmq.socket('req');

var x = 0;
requester.on("message", function(reply) {
  console.log("Received reply", x, ": [", reply.toString(), ']');
  x += 1;
  if (x === 10) {
    requester.close();
    process.exit(0);
  }
});

requester.connect("tcp://localhost:5555");

for (var i = 0; i < 10; i++) {
  console.log("Sending request", i, '...');
  requester.send("Hello");
}

process.on('SIGINT', function() {
  requester.close();
});
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Node.js/hwclient.js)

hwclient: Hello World client in Objective-C

```objective-c
//
//  Hello World client
//  Connects REQ socket to tcp://localhost:5555
//  Sends "Hello" to server, expects "World" back
//
#import "ZMQObjC.h"

int
main (void)
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	ZMQContext *ctx = [[[ZMQContext alloc] initWithIOThreads:1U] autorelease];

	/* Get a socket to talk to clients. */
	NSLog(@"Connecting to hello world server...");
	static NSString *const kEndpoint = @"tcp://localhost:5555";
	ZMQSocket *requester = [ctx socketWithType:ZMQ_REQ];
	BOOL didBind = [requester connectToEndpoint:kEndpoint];
	if (!didBind) {
		NSLog(@"*** Failed to bind to endpoint [%@].", kEndpoint);
		return EXIT_FAILURE;
	}

	static const int kMaxRequest = 10;
	NSData *const request = [@"Hello" dataUsingEncoding:NSUTF8StringEncoding];
	for (int request_nbr = 0; request_nbr < kMaxRequest; ++request_nbr) {
		NSAutoreleasePool *localPool = [[NSAutoreleasePool alloc] init];

		NSLog(@"Sending request %d.", request_nbr);
		[requester sendData:request withFlags:0];
		NSData *reply = [requester receiveDataWithFlags:0];
		NSString *text = [[[NSString alloc]\
				initWithData:reply encoding:NSUTF8StringEncoding] autorelease];
		NSLog(@"Received reply %d: %@", request_nbr, text);

		[localPool drain];
	}

	[requester close];
	[pool drain];
	return EXIT_SUCCESS;
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Objective-C/hwclient.m)

hwclient: Hello World client in ooc

The example **hwclient** is missing in **ooc**:
[Contribute Translation](https://zguide.zeromq.org/translate)

hwclient: Hello World client in Perl

```perl
# Hello World client in Perl

use strict;
use warnings;
use v5.10;

use ZMQ::FFI;
use ZMQ::FFI::Constants qw(ZMQ_REQ);

say "Connecting to hello world server...";
my $context = ZMQ::FFI->new();
my $requestor = $context->socket(ZMQ_REQ);
$requestor->connect("tcp://localhost:5555");

for my $request_nbr (0..9) {
    say "Sending Hello $request_nbr...";
    $requestor->send("Hello");
    $requestor->recv();
    say "Received World $request_nbr";
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Perl/hwclient.pl)

hwclient: Hello World client in PHP

```php
<?php
/*
 *  Hello World client
 *  Connects REQ socket to tcp://localhost:5555
 *  Sends "Hello" to server, expects "World" back
 * @author Ian Barber <ian(dot)barber(at)gmail(dot)com>
 */

$context = new ZMQContext();

//  Socket to talk to server
echo "Connecting to hello world server...\n";
$requester = new ZMQSocket($context, ZMQ::SOCKET_REQ);
$requester->connect("tcp://localhost:5555");

for ($request_nbr = 0; $request_nbr != 10; $request_nbr++) {
    printf ("Sending request %d...\n", $request_nbr);
    $requester->send("Hello");

    $reply = $requester->recv();
    printf ("Received reply %d: [%s]\n", $request_nbr, $reply);
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/PHP/hwclient.php)

hwclient: Hello World client in Python

```python
#
#   Hello World client in Python
#   Connects REQ socket to tcp://localhost:5555
#   Sends "Hello" to server, expects "World" back
#

import zmq

context = zmq.Context()

#  Socket to talk to server
print("Connecting to hello world server...")
socket = context.socket(zmq.REQ)
socket.connect("tcp://localhost:5555")

#  Do 10 requests, waiting each time for a response
for request in range(10):
    print(f"Sending request {request} ...")
    socket.send_string("Hello")

    #  Get the reply.
    message = socket.recv()
    print(f"Received reply {request} [ {message} ]")
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Python/hwclient.py)

hwclient: Hello World client in Q

```q
//  Hello World client
//  Connects REQ socket to tcp://localhost:5555
//  Sends "Hello" to server, expects "World" back
\l qzmq.q
zclock.log "Connecting to hello world server..."
ctx:zctx.new[]
//  Socket to talk to server
requester:zsocket.new[ctx; zmq`REQ]
zsocket.connect[requester; `tcp://127.0.0.1:5555]
do[10; m:zmsg.new[]; zmsg.push[m; f:zframe.new["Hello"]];\
  zmsg.send[m; requester]; zmsg.dump[zmsg.recv[requester]]]
zsocket.destroy[ctx; requester]
zctx.destroy[ctx]
\\
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Q/hwclient.q)

hwclient: Hello World client in Racket

The example **hwclient** is missing in **Racket**:
[Contribute Translation](https://zguide.zeromq.org/translate)

hwclient: Hello World client in Ruby

The example **hwclient** is missing in **Ruby**:
[Contribute Translation](https://zguide.zeromq.org/translate)

hwclient: Hello World client in Rust

The example **hwclient** is missing in **Rust**:
[Contribute Translation](https://zguide.zeromq.org/translate)

hwclient: Hello World client in Scala

The example **hwclient** is missing in **Scala**:
[Contribute Translation](https://zguide.zeromq.org/translate)

hwclient: Hello World client in Tcl

The example **hwclient** is missing in **Tcl**:
[Contribute Translation](https://zguide.zeromq.org/translate)

hwclient: Hello World client in OCaml

The example **hwclient** is missing in **OCaml**:
[Contribute Translation](https://zguide.zeromq.org/translate)

C \|

C++ \|

C# \|

CL \|

Delphi \|

Erlang \|

Elixir \|

F# \|

Felix \|

Go \|

Haskell \|

Haxe \|

Java \|

Julia \|

Lua \|

Node.js \|

Objective-C \|

Perl \|

PHP \|

Python \|

Q \|

[Ada \|\\
\\
Basic \|\\
\\
ooc \|\\
\\
Racket \|\\
\\
Ruby \|\\
\\
Rust \|\\
\\
Scala \|\\
\\
Tcl \|\\
\\
OCaml](https://zguide.zeromq.org/translate)

Now this looks too simple to be realistic, but ZeroMQ sockets have, as we already learned, superpowers. You could throw thousands of clients at this server, all at once, and it would continue to work happily and quickly. For fun, try starting the client and _then_ starting the server, see how it all still works, then think for a second what this means.

Let us explain briefly what these two programs are actually doing. They create a ZeroMQ context to work with, and a socket. Don’t worry what the words mean. You’ll pick it up. The server binds its REP (reply) socket to port 5555. The server waits for a request in a loop, and responds each time with a reply. The client sends a request and reads the reply back from the server.

If you kill the server (Ctrl-C) and restart it, the client won’t recover properly. Recovering from crashing processes isn’t quite that easy. Making a reliable request-reply flow is complex enough that we won’t cover it until
[Chapter 4 - Reliable Request-Reply Patterns](https://zguide.zeromq.org/docs/chapter4/#reliable-request-reply).

There is a lot happening behind the scenes but what matters to us programmers is how short and sweet the code is, and how often it doesn’t crash, even under a heavy load. This is the request-reply pattern, probably the simplest way to use ZeroMQ. It maps to RPC and the classic client/server model.

## A Minor Note on Strings  [\#](https://zguide.zeromq.org/docs/chapter1/\#A-Minor-Note-on-Strings)

ZeroMQ doesn’t know anything about the data you send except its size in bytes. That means you are responsible for formatting it safely so that applications can read it back. Doing this for objects and complex data types is a job for specialized libraries like Protocol Buffers. But even for strings, you need to take care.

In C and some other languages, strings are terminated with a null byte. We could send a string like “HELLO” with that extra null byte:

```c
zmq_send (requester, "Hello", 6, 0);
```

However, if you send a string from another language, it probably will not include that null byte. For example, when we send that same string in Python, we do this:

```python
socket.send ("Hello")
```

Then what goes onto the wire is a length (one byte for shorter strings) and the string contents as individual characters.

**Figure 3 - A ZeroMQ string**

![](https://zguide.zeromq.org/images/fig3.png)

And if you read this from a C program, you will get something that looks like a string, and might by accident act like a string (if by luck the five bytes find themselves followed by an innocently lurking null), but isn’t a proper string. When your client and server don’t agree on the string format, you will get weird results.

When you receive string data from ZeroMQ in C, you simply cannot trust that it’s safely terminated. Every single time you read a string, you should allocate a new buffer with space for an extra byte, copy the string, and terminate it properly with a null.

So let’s establish the rule that **ZeroMQ strings are length-specified and are sent on the wire _without_ a trailing null**. In the simplest case (and we’ll do this in our examples), a ZeroMQ string maps neatly to a ZeroMQ message frame, which looks like the above figure–a length and some bytes.

Here is what we need to do, in C, to receive a ZeroMQ string and deliver it to the application as a valid C string:

```c
//  Receive ZeroMQ string from socket and convert into C string
//  Chops string at 255 chars, if it's longer
static char *
s_recv (void *socket) {
    char buffer [256];
    int size = zmq_recv (socket, buffer, 255, 0);
    if (size == -1)
        return NULL;
    if (size > 255)
        size = 255;
    buffer [size] = '\0';
    /* use strndup(buffer, sizeof(buffer)-1) in *nix */
    return strdup (buffer);
}
```

This makes a handy helper function and in the spirit of making things we can reuse profitably, let’s write a similar `s_send` function that sends strings in the correct ZeroMQ format, and package this into a header file we can reuse.

The result is `zhelpers.h`, which lets us write sweeter and shorter ZeroMQ applications in C. It is a fairly long source, and only fun for C developers, so
[read it at leisure](https://github.com/imatix/zguide/blob/master/examples/C/zhelpers.h).

## A Note on the Naming Convention  [\#](https://zguide.zeromq.org/docs/chapter1/\#A-Note-on-the-Naming-Convention)

The prefix `s_` used in `zhelpers.h` and the examples which follow in this guide is an indicator for static methods or variables.

## Version Reporting  [\#](https://zguide.zeromq.org/docs/chapter1/\#Version-Reporting)

ZeroMQ does come in several versions and quite often, if you hit a problem, it’ll be something that’s been fixed in a later version. So it’s a useful trick to know _exactly_ what version of ZeroMQ you’re actually linking with.

Here is a tiny program that does that:

version: ZeroMQ version reporting in Ada

The example **version** is missing in **Ada**:
[Contribute Translation](https://zguide.zeromq.org/translate)

version: ZeroMQ version reporting in Basic

The example **version** is missing in **Basic**:
[Contribute Translation](https://zguide.zeromq.org/translate)

version: ZeroMQ version reporting in C

```c
//  Report 0MQ version

#include <zmq.h>

int main (void)
{
    int major, minor, patch;
    zmq_version (&major, &minor, &patch);
    printf ("Current 0MQ version is %d.%d.%d\n", major, minor, patch);
    return 0;
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/C/version.c)

version: ZeroMQ version reporting in C++

```c++
//
//  Report 0MQ version
//
#include "zhelpers.hpp"

int main ()
{
    s_version ();
    return EXIT_SUCCESS;
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/C++/version.cpp)

version: ZeroMQ version reporting in C#

```c#
﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;

using ZeroMQ;
using ZeroMQ.lib;

namespace Examples
{
	static partial class Program
	{
		public static void Version(string[] args)
		{
			//
			// Report 0MQ version
			//
			// Author: metadings
			//

			// Console.WriteLine(zmq.Version);

			int major, minor, patch;
			zmq.version(out major, out minor, out patch);
			Console.WriteLine("{0}.{1}.{2}", major, minor, patch);
		}
	}
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/CSharp/version.cs)

version: ZeroMQ version reporting in CL

```cl
;;; -*- Mode:Lisp; Syntax:ANSI-Common-Lisp; -*-
;;;
;;; Report 0MQ version
;;;
;;; Kamil Shakirov <kamils80@gmail.com>
;;;

(defpackage #:zguide.zversion
  (:nicknames #:zversion)
  (:use #:cl #:zhelpers)
  (:export #:main))

(in-package :zguide.zversion)

(defun main ()
  (version))
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/CL/version.lisp)

version: ZeroMQ version reporting in Delphi

```delphi
program version;
//
//  Report 0MQ version
//  @author Varga Balazs <bb.varga@gmail.com>
//

{$APPTYPE CONSOLE}

uses
    SysUtils
  , zmqapi
  ;

var
  major,
  minor,
  patch: Integer;
begin
  ZMQVersion( major, minor, patch );
  Writeln( Format( 'Current 0MQ version is %d.%d.%d', [major, minor, patch]) );
end.
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Delphi/version.dpr)

version: ZeroMQ version reporting in Erlang

```erlang
#! /usr/bin/env escript
%%
%% Report 0MQ version
%%

main(_) ->
    {Maj, Min, Patch} = erlzmq:version(),
    io:format("Current 0MQ version is ~b.~b.~b~n", [Maj, Min, Patch]).
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Erlang/version.es)

version: ZeroMQ version reporting in Elixir

```elixir
defmodule Version do
  @moduledoc """
  Generated by erl2ex (http://github.com/dazuma/erl2ex)
  From Erlang source: (Unknown source file)
  At: 2019-12-20 13:57:38

  """

  def main() do
    {maj, var_min, patch} = :erlzmq.version()
    :io.format('Current 0MQ version is ~b.~b.~b~n', [maj, var_min, patch])
  end

end

Version.main
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Elixir/version.exs)

version: ZeroMQ version reporting in F#

```f#
(*
Report 0MQ version
*)

#r @"bin/fszmq.dll"
open fszmq

#load "zhelpers.fs"

let main () =
  match ZMQ.version with
  | Version(m,n,p)  -> printfn "Current 0MQ version is %d.%d.%d" m n p
  | Unknown         -> printfn "Unable to determine current 0MQ version"
  EXIT_SUCCESS

main ()
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/FSharp/version.fsx)

version: ZeroMQ version reporting in Felix

```felix
println$ f"Current 0MQ version is %d.%d.%d" #ZeroMQ::zmq_version;
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Felix/version.flx)

version: ZeroMQ version reporting in Go

```go
//
// 0MQ version example.
//
// Author: Max Riveiro <kavu13@gmail.com>
// Requires: http://github.com/alecthomas/gozmq
//
package main

import (
	"fmt"
	zmq "github.com/alecthomas/gozmq"
)

func main() {
	major, minor, patch := zmq.Version()
	fmt.Printf("Current 0MQ version is %d.%d.%d\n", major, minor, patch)
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Go/version.go)

version: ZeroMQ version reporting in Haskell

```haskell
module Main where

import System.ZMQ4 (version)
import Text.Printf (printf)

main :: IO ()
main = do
    (major, minor, patch) <- version
    printf "Current 0MQ version is %d.%d.%d" major minor patch
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Haskell/version.hs)

version: ZeroMQ version reporting in Haxe

The example **version** is missing in **Haxe**:
[Contribute Translation](https://zguide.zeromq.org/translate)

version: ZeroMQ version reporting in Java

```java
package guide;

import org.zeromq.ZMQ;

//  Report 0MQ version
public class version
{
    public static void main(String[] args)
    {
        String version = ZMQ.getVersionString();
        int fullVersion = ZMQ.getFullVersion();

        System.out.println(
            String.format(
                "Version string: %s, Version int: %d", version, fullVersion
            )
        );
    }
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Java/version.java)

version: ZeroMQ version reporting in Julia

```julia
#!/usr/bin/env julia

using ZMQ

println("Current ZMQ version is $(ZMQ.version)")
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Julia/version.jl)

version: ZeroMQ version reporting in Lua

```lua
--
--  Report 0MQ version
--
--  Author: Robert G. Jakabosky <bobby@sharedrealm.com>
--
require"zmq"

print("Current 0MQ version is " .. table.concat(zmq.version(), '.'))
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Lua/version.lua)

version: ZeroMQ version reporting in Node.js

```node.js
// Report 0MQ version in Node.js

var zmq = require('zeromq');

console.log("Current 0MQ version is " + zmq.version);
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Node.js/version.js)

version: ZeroMQ version reporting in Objective-C

```objective-c
/* Reports the 0MQ version. */
#import "ZMQObjC.h"

int
main(void)
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	int major = 0;
	int minor = 0;
	int patch = 0;
	[ZMQContext getZMQVersionMajor:&major minor:&minor patch:&patch];
	NSLog(@"Current 0MQ version is %d.%d.%d.", major, minor, patch);
	[pool drain];
	return EXIT_SUCCESS;
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Objective-C/version.m)

version: ZeroMQ version reporting in ooc

The example **version** is missing in **ooc**:
[Contribute Translation](https://zguide.zeromq.org/translate)

version: ZeroMQ version reporting in Perl

```perl
# Report 0MQ version in Perl

use strict;
use warnings;
use v5.10;

use ZMQ::FFI;

my ($major, $minor, $patch) = ZMQ::FFI->new->version;
say "Current 0MQ version is $major.$minor.$patch";
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Perl/version.pl)

version: ZeroMQ version reporting in PHP

```php
<?php
/* Report 0MQ version
 *
 * @author Ian Barber <ian(dot)barber(at)gmail(dot)com>
 */

if (class_exists("ZMQ") && defined("ZMQ::LIBZMQ_VER")) {
    echo ZMQ::LIBZMQ_VER, PHP_EOL;
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/PHP/version.php)

version: ZeroMQ version reporting in Python

```python
# Report 0MQ version
#
# Author: Lev Givon <lev(at)columbia(dot)edu>

import zmq

print(f"Current libzmq version is {zmq.zmq_version()}")
print(f"Current  pyzmq version is {zmq.__version__}")
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Python/version.py)

version: ZeroMQ version reporting in Q

```q
//  Report 0MQ version
\l qzmq.q
mnp:libzmq.version[]
zclock.log "Current 0MQ version is ","." sv (string mnp)
\\
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Q/version.q)

version: ZeroMQ version reporting in Racket

The example **version** is missing in **Racket**:
[Contribute Translation](https://zguide.zeromq.org/translate)

version: ZeroMQ version reporting in Ruby

The example **version** is missing in **Ruby**:
[Contribute Translation](https://zguide.zeromq.org/translate)

version: ZeroMQ version reporting in Rust

The example **version** is missing in **Rust**:
[Contribute Translation](https://zguide.zeromq.org/translate)

version: ZeroMQ version reporting in Scala

The example **version** is missing in **Scala**:
[Contribute Translation](https://zguide.zeromq.org/translate)

version: ZeroMQ version reporting in Tcl

The example **version** is missing in **Tcl**:
[Contribute Translation](https://zguide.zeromq.org/translate)

version: ZeroMQ version reporting in OCaml

The example **version** is missing in **OCaml**:
[Contribute Translation](https://zguide.zeromq.org/translate)

C \|

C++ \|

C# \|

CL \|

Delphi \|

Erlang \|

Elixir \|

F# \|

Felix \|

Go \|

Haskell \|

Java \|

Julia \|

Lua \|

Node.js \|

Objective-C \|

Perl \|

PHP \|

Python \|

Q \|

[Ada \|\\
\\
Basic \|\\
\\
Haxe \|\\
\\
ooc \|\\
\\
Racket \|\\
\\
Ruby \|\\
\\
Rust \|\\
\\
Scala \|\\
\\
Tcl \|\\
\\
OCaml](https://zguide.zeromq.org/translate)

## Getting the Message Out  [\#](https://zguide.zeromq.org/docs/chapter1/\#Getting-the-Message-Out)

The second classic pattern is one-way data distribution, in which a server pushes updates to a set of clients. Let’s see an example that pushes out weather updates consisting of a zip code, temperature, and relative humidity. We’ll generate random values, just like the real weather stations do.

Here’s the server. We’ll use port 5556 for this application:

wuserver: Weather update server in Ada

The example **wuserver** is missing in **Ada**:
[Contribute Translation](https://zguide.zeromq.org/translate)

wuserver: Weather update server in Basic

The example **wuserver** is missing in **Basic**:
[Contribute Translation](https://zguide.zeromq.org/translate)

wuserver: Weather update server in C

```c
//  Weather update server
//  Binds PUB socket to tcp://*:5556
//  Publishes random weather updates

#include "zhelpers.h"

int main (void)
{
    //  Prepare our context and publisher
    void *context = zmq_ctx_new ();
    void *publisher = zmq_socket (context, ZMQ_PUB);
    int rc = zmq_bind (publisher, "tcp://*:5556");
    assert (rc == 0);

    //  Initialize random number generator
    srandom ((unsigned) time (NULL));
    while (1) {
        //  Get values that will fool the boss
        int zipcode, temperature, relhumidity;
        zipcode     = randof (100000);
        temperature = randof (215) - 80;
        relhumidity = randof (50) + 10;

        //  Send message to all subscribers
        char update [20];
        sprintf (update, "%05d %d %d", zipcode, temperature, relhumidity);
        s_send (publisher, update);
    }
    zmq_close (publisher);
    zmq_ctx_destroy (context);
    return 0;
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/C/wuserver.c)

wuserver: Weather update server in C++

```c++
//
//  Weather update server in C++
//  Binds PUB socket to tcp://*:5556
//  Publishes random weather updates
//
#include <zmq.hpp>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#if (defined (WIN32))
#include <zhelpers.hpp>
#endif

#define within(num) (int) ((float) num * random () / (RAND_MAX + 1.0))

int main () {

    //  Prepare our context and publisher
    zmq::context_t context (1);
    zmq::socket_t publisher (context, zmq::socket_type::pub);
    publisher.bind("tcp://*:5556");
    publisher.bind("ipc://weather.ipc");				// Not usable on Windows.

    //  Initialize random number generator
    srandom ((unsigned) time (NULL));
    while (1) {

        int zipcode, temperature, relhumidity;

        //  Get values that will fool the boss
        zipcode     = within (100000);
        temperature = within (215) - 80;
        relhumidity = within (50) + 10;

        //  Send message to all subscribers
        zmq::message_t message(20);
        snprintf ((char *) message.data(), 20 ,
        	"%05d %d %d", zipcode, temperature, relhumidity);
        publisher.send(message, zmq::send_flags::none);

    }
    return 0;
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/C++/wuserver.cpp)

wuserver: Weather update server in C#

```c#
﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading;

using ZeroMQ;

namespace Examples
{
	static partial class Program
	{
		public static void WUServer(string[] args)
		{
			//
			// Weather update server
			// Binds PUB socket to tcp://*:5556
			// Publishes random weather updates
			//
			// Author: metadings
			//

			// Prepare our context and publisher
			using (var context = new ZContext())
			using (var publisher = new ZSocket(context, ZSocketType.PUB))
			{
				string address = "tcp://*:5556";
				Console.WriteLine("I: Publisher.Bind'ing on {0}", address);
				publisher.Bind(address);

				/* foreach (IPAddress localAddress in WUProxy_GetPublicIPs())
				{
					var epgmAddress = string.Format("epgm://{0};239.192.1.1:8100", localAddress);
					Console.WriteLine("I: Publisher.Bind'ing on {0}...", epgmAddress);
					publisher.Bind(epgmAddress);
				} */

				// Initialize random number generator
				var rnd = new Random();

				while (true)
				{
					// Get values that will fool the boss
					int zipcode = rnd.Next(99999);
					int temperature = rnd.Next(-55, +45);

					// Send message to all subscribers
					var update = string.Format("{0:D5} {1}", zipcode, temperature);
					using (var updateFrame = new ZFrame(update))
					{
						publisher.Send(updateFrame);
					}
				}
			}
		}
	}
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/CSharp/wuserver.cs)

wuserver: Weather update server in CL

```cl
;;; -*- Mode:Lisp; Syntax:ANSI-Common-Lisp; -*-
;;;
;;;  Weather update server in Common Lisp
;;;  Binds PUB socket to tcp://*:5556
;;;  Publishes random weather updates
;;;
;;; Kamil Shakirov <kamils80@gmail.com>
;;;

(defpackage #:zguide.wuserver
  (:nicknames #:wuserver)
  (:use #:cl #:zhelpers)
  (:export #:main))

(in-package :zguide.wuserver)

(defun main ()
  ;; Prepare our context and socket
  (zmq:with-context (context 1)
    (zmq:with-socket (publisher context zmq:pub)
      (zmq:bind publisher "tcp://*:5556")
      (zmq:bind publisher "ipc://weather.ipc")

      (loop
        ;; Get values that will fool the boss
        (let ((zipcode (within 100000))
              (temperature (- (within 215) 80))
              (relhumidity (+ (within 50) 10)))

          ;; Send message to all subscribers
          (let ((message
                 (make-instance 'zmq:msg
                                :data (format nil "~5,'0D ~D ~D"
                                              zipcode
                                              temperature
                                              relhumidity))))

            ;; Send message to all subscribers
            (zmq:send publisher message))))))

  (cleanup))
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/CL/wuserver.lisp)

wuserver: Weather update server in Delphi

```delphi
program wuserver;
//
//  Weather update server
//  Binds PUB socket to tcp://*:5556
//  Publishes random weather updates
//  @author Varga Balazs <bb.varga@gmail.com>
//
{$APPTYPE CONSOLE}

uses
    SysUtils
  , zmqapi
  ;

var
  context : TZMQContext;
  publisher : TZMQSocket;

  zipcode,
  temperature,
  relhumidity: Integer;
begin
  //  Prepare our context and publisher
  context := TZMQContext.create;
  publisher := Context.Socket( stPub );
  publisher.bind( 'tcp://*:5556' );
  {$ifdef unix}
  publisher.bind( 'ipc://weather.ipc' );
  {$endif}

  Randomize;
  while True do
  begin
    zipcode := Random( 100000 );
    temperature := Random( 215 ) - 80;
    relhumidity := Random( 50 ) + 10;
    publisher.Send( Format( '%05d %d %d', [zipcode, temperature, relhumidity] ) );
  end;
  publisher.Free;
  context.Free;
end.
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Delphi/wuserver.dpr)

wuserver: Weather update server in Erlang

```erlang
#! /usr/bin/env escript
%%
%% Weather update server
%% Binds PUB socket to tcp://*.5556
%% Publishes random weather updates
%%

main(_Args) ->
    application:start(chumak),
    {ok, Publisher} = chumak:socket(pub),

    case chumak:bind(Publisher, tcp, "localhost", 5556) of
        {ok, _BindPid} ->
            io:format("Binding OK with Pid: ~p\n", [Publisher]);
        {error, Reason} ->
            io:format("Connection Failed for this reason: ~p\n", [Reason]);
        X ->
            io:format("Unhandled reply for bind ~p \n", [X])
    end,
    loop(Publisher).

loop(Publisher) ->
    Zipcode = rand:uniform(100000),
    Temperature = rand:uniform(135),
    Relhumidity = rand:uniform(50) + 10,

    BinZipCode = erlang:integer_to_binary(Zipcode),
    BinTemperature = erlang:integer_to_binary(Temperature),
    BinRelhumidity = erlang:integer_to_binary(Relhumidity),
    ok = chumak:send(Publisher, [BinZipCode, " ", BinTemperature, " ", BinRelhumidity]),
    loop(Publisher).
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Erlang/wuserver.es)

wuserver: Weather update server in Elixir

```elixir
defmodule Wuserver do
  @moduledoc """
  Generated by erl2ex (http://github.com/dazuma/erl2ex)
  From Erlang source: (Unknown source file)
  At: 2019-12-20 13:57:40

  """

  def main(_) do
    {:ok, context} = :erlzmq.context()
    {:ok, publisher} = :erlzmq.socket(context, :pub)
    :ok = :erlzmq.bind(publisher, 'tcp://*:5556')
    loop(publisher)
    :ok = :erlzmq.close(publisher)
    :ok = :erlzmq.term(context)
  end

  def loop(publisher) do
    zipcode = :random.uniform(100000)
    temperature = :random.uniform(215) - 80
    relhumidity = :random.uniform(50) + 10
    msg = :erlang.list_to_binary(:io_lib.format('~5..0b ~b ~b', [zipcode, temperature, relhumidity]))
    :ok = :erlzmq.send(publisher, msg)
    loop(publisher)
  end

end

Wuserver.main(:ok)
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Elixir/wuserver.exs)

wuserver: Weather update server in F#

```f#
(*
Weather update server
Binds PUB socket to tcp://*:5556
Publishes random weather updates
*)

#r "bin/fszmq.dll"
open fszmq

#load "zhelpers.fs"

let main () =
  // prepare our context and publisher
  use context   = new Context(1);
  use publisher = context |> Context.pub
  "tcp://*:5556" |> Socket.bind publisher
  // "icp://weather.ipc" |> Socket.bind publisher
  //NOTE: IPC transport is not currently supported on Microsoft Windows

  // initialize random number generator
  let rand = srandom ()
  while true do
    // get values that will fool the boss
    let zipcode, temperature, relhumidity =
      rand.Next 100000, (rand.Next 215) - 80, (rand.Next 50) + 10

    // send message to all subscribers
    let update = sprintf "%05d %d %d" zipcode temperature relhumidity
    update |> s_send publisher

  EXIT_SUCCESS

main ()
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/FSharp/wuserver.fsx)

wuserver: Weather update server in Felix

```felix
//
//  Weather update server
//  Binds PUB socket to tcp://*:5556
//  Publishes random weather updates
//
open ZMQ;

//  Prepare our context and publisher
var context = zmq_init 1;
var publisher = context.mk_socket ZMQ_PUB;
publisher.bind "tcp://*:5556";
publisher.bind "ipc://weather.ipc";

while true do
  //  Get values that will fool the boss
  zipcode     := #rand % 1000+1000;
  temperature := #rand % 80 - 20; // Oztraila mate!
  relhumidity := #rand % 50 + 10;

                     //  Send message to all subscribers
  update := f"%03d %d %d" (zipcode, temperature, relhumidity);
  publisher.send_string update;
done
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Felix/wuserver.flx)

wuserver: Weather update server in Go

```go
//
//   Weather update server
//   Binds PUB socket to tcp://*:5556
//   Publishes random weather updates
//
package main

import (
	"fmt"
	zmq "github.com/alecthomas/gozmq"
	"math/rand"
	"time"
)

func main() {
	context, _ := zmq.NewContext()
	socket, _ := context.NewSocket(zmq.PUB)
	defer context.Close()
	defer socket.Close()
	socket.Bind("tcp://*:5556")
	socket.Bind("ipc://weather.ipc")

	// Seed the random number generator
	rand.Seed(time.Now().UnixNano())

	// loop for a while aparently
	for {

		//  make values that will fool the boss
		zipcode := rand.Intn(100000)
		temperature := rand.Intn(215) - 80
		relhumidity := rand.Intn(50) + 10

		msg := fmt.Sprintf("%d %d %d", zipcode, temperature, relhumidity)

		//  Send message to all subscribers
		socket.Send([]byte(msg), 0)
	}
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Go/wuserver.go)

wuserver: Weather update server in Haskell

```haskell
{-# LANGUAGE ScopedTypeVariables #-}

--  Weather update server
--  Binds PUB socket to tcp://*:5556
--  Publishes random weather updates

module Main where

import           Control.Monad
import qualified Data.ByteString.Char8 as BS
import           System.Random
import           System.ZMQ4.Monadic
import           Text.Printf

main :: IO ()
main = runZMQ $ do
    -- Prepare our publisher
    publisher <- socket Pub
    bind publisher "tcp://*:5556"

    forever $ do
        -- Get values that will fool the boss
        zipcode     :: Int <- liftIO $ randomRIO (0, 100000)
        temperature :: Int <- liftIO $ randomRIO (-30, 135)
        relhumidity :: Int <- liftIO $ randomRIO (10, 60)

        -- Send message to all subscribers
        let update = printf "%05d %d %d" zipcode temperature relhumidity
        send publisher [] (BS.pack update)
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Haskell/wuserver.hs)

wuserver: Weather update server in Haxe

```haxe
package ;
import haxe.io.Bytes;
import neko.Lib;
import org.zeromq.ZMQ;
import org.zeromq.ZMQContext;
import org.zeromq.ZMQSocket;

/**
 * Weather update server in Haxe
 * Binds PUB socket to tcp://*:5556
 * Publishes random weather updates
 *
 * See: http://zguide.zeromq.org/page:all#Getting-the-Message-Out
 *
 * Use with WUClient.hx
 */
class WUServer
{

	public static function main() {
		var context:ZMQContext = ZMQContext.instance();

		Lib.println("** WUServer (see: http://zguide.zeromq.org/page:all#Getting-the-Message-Out)");

		var publisher:ZMQSocket = context.socket(ZMQ_PUB);
		publisher.bind("tcp://127.0.0.1:5556");

		while (true) {
			// Get values that will fool the boss
			var zipcode, temperature, relhumidity;
			zipcode = Std.random(100000) + 1;
			temperature = Std.random(215) - 80 + 1;
			relhumidity = Std.random(50) + 10 + 1;

			// Send message to all subscribers
			var update:String = zipcode + " " + temperature + " " + relhumidity;
			publisher.sendMsg(Bytes.ofString(update));
		}
	}
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Haxe/wuserver.hx)

wuserver: Weather update server in Java

```java
package guide;

import java.util.Random;

import org.zeromq.SocketType;
import org.zeromq.ZMQ;
import org.zeromq.ZContext;

//
//  Weather update server in Java
//  Binds PUB socket to tcp://*:5556
//  Publishes random weather updates
//
public class wuserver
{
    public static void main(String[] args) throws Exception
    {
        //  Prepare our context and publisher
        try (ZContext context = new ZContext()) {
            ZMQ.Socket publisher = context.createSocket(SocketType.PUB);
            publisher.bind("tcp://*:5556");
            publisher.bind("ipc://weather");

            //  Initialize random number generator
            Random srandom = new Random(System.currentTimeMillis());
            while (!Thread.currentThread().isInterrupted()) {
                //  Get values that will fool the boss
                int zipcode, temperature, relhumidity;
                zipcode = 10000 + srandom.nextInt(10000);
                temperature = srandom.nextInt(215) - 80 + 1;
                relhumidity = srandom.nextInt(50) + 10 + 1;

                //  Send message to all subscribers
                String update = String.format(
                    "%05d %d %d", zipcode, temperature, relhumidity
                );
                publisher.send(update, 0);
            }
        }
    }
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Java/wuserver.java)

wuserver: Weather update server in Julia

```julia
#!/usr/bin/env julia

#
#   Weather update server
#   Binds PUB socket to tcp://*:5556
#   Publishes random weather updates
#

using ZMQ

context = Context()
socket = Socket(context, PUB)
bind(socket, "tcp://*:5556")

while true
    zipcode = rand(10000:99999)
    temperature = rand(-80:135)
    relhumidity = rand(10:60)
    message = "$zipcode $temperature $relhumidity"
    send(socket, message)
    yield()
end

close(socket)
close(context)
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Julia/wuserver.jl)

wuserver: Weather update server in Lua

```lua
--
--  Weather update server
--  Binds PUB socket to tcp://*:5556
--  Publishes random weather updates
--
--  Author: Robert G. Jakabosky <bobby@sharedrealm.com>
--
require"zmq"

--  Prepare our context and publisher
local context = zmq.init(1)
local publisher = context:socket(zmq.PUB)
publisher:bind("tcp://*:5556")
publisher:bind("ipc://weather.ipc")

--  Initialize random number generator
math.randomseed(os.time())
while (1) do
    --  Get values that will fool the boss
    local zipcode, temperature, relhumidity
    zipcode     = math.random(0, 99999)
    temperature = math.random(-80, 135)
    relhumidity = math.random(10, 60)

    --  Send message to all subscribers
    publisher:send(string.format("%05d %d %d", zipcode, temperature, relhumidity))
end
publisher:close()
context:term()
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Lua/wuserver.lua)

wuserver: Weather update server in Node.js

```node.js
// Weather update server in node.js
// Binds PUB socket to tcp://*:5556
// Publishes random weather updates

var zmq = require('zeromq')
  , publisher = zmq.socket('pub');

publisher.bindSync("tcp://*:5556");
publisher.bindSync("ipc://weather.ipc");

function zeropad(num) {
  return num.toString().padStart(5, "0");
};

function rand(upper, extra) {
  var num = Math.abs(Math.round(Math.random() * upper));
  return num + (extra || 0);
};

while (true) {
  // Get values that will fool the boss
  var zipcode     = rand(100000)
    , temperature = rand(215, -80)
    , relhumidity = rand(50, 10)
    , update      = `${zeropad(zipcode)} ${temperature} ${relhumidity}`;
  publisher.send(update);
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Node.js/wuserver.js)

wuserver: Weather update server in Objective-C

```objective-c
//
//  Weather update server
//  Binds PUB socket to tcp://*:5556
//  Publishes random weather updates
//
#import "ZMQObjC.h"
#import "ZMQHelper.h"

int
main(void)
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

	//  Prepare our context and publisher
	ZMQContext *ctx = [[[ZMQContext alloc] initWithIOThreads:1U] autorelease];
	ZMQSocket *publisher = [ctx socketWithType:ZMQ_PUB];
	[publisher bindToEndpoint:@"tcp://*:5556"];
	[publisher bindToEndpoint:@"ipc://weather.ipc"];

	//  Initialize random number generator
	srandom ((unsigned) time (NULL));
	for (;;) {
		//  Get values that will fool the boss
		int zipcode, temperature, relhumidity;
		zipcode     = within (100000);
		temperature = within (215) - 80;
		relhumidity = within (50) + 10;

		// Send message to all subscribers
		NSString *update = [NSString stringWithFormat:@"%05d %d %d",\
				zipcode, temperature, relhumidity];
		NSData *data = [update dataUsingEncoding:NSUTF8StringEncoding];
		[publisher sendData:data withFlags:0];
	}
	[publisher close];
	[pool drain];
	return EXIT_SUCCESS;
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Objective-C/wuserver.m)

wuserver: Weather update server in ooc

The example **wuserver** is missing in **ooc**:
[Contribute Translation](https://zguide.zeromq.org/translate)

wuserver: Weather update server in Perl

```perl
# Weather update server in Perl
# Binds PUB socket to tcp://*:5556
# Publishes random weather updates

use strict;
use warnings;

use ZMQ::FFI;
use ZMQ::FFI::Constants qw(ZMQ_PUB);

my $context   = ZMQ::FFI->new();
my $publisher = $context->socket(ZMQ_PUB);
$publisher->bind("tcp://*:5556");

my ($update, $zipcode, $temperature, $relhumidity);

while (1) {
    $zipcode     = rand(100_000);
    $temperature = rand(215) - 80;
    $relhumidity = rand(50) + 10;

    $update = sprintf('%d %d %d', $zipcode,$temperature,$relhumidity);

    $publisher->send($update);
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Perl/wuserver.pl)

wuserver: Weather update server in PHP

```php
<?php
/*
 *  Weather update server
 *  Binds PUB socket to tcp://*:5556
 *  Publishes random weather updates
 * @author Ian Barber <ian(dot)barber(at)gmail(dot)com>
 */

//  Prepare our context and publisher
$context = new ZMQContext();
$publisher = $context->getSocket(ZMQ::SOCKET_PUB);
$publisher->bind("tcp://*:5556");
$publisher->bind("ipc://weather.ipc");

while (true) {
    //  Get values that will fool the boss
    $zipcode     = mt_rand(0, 100000);
    $temperature = mt_rand(-80, 135);
    $relhumidity = mt_rand(10, 60);

    //  Send message to all subscribers
    $update = sprintf ("%05d %d %d", $zipcode, $temperature, $relhumidity);
    $publisher->send($update);
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/PHP/wuserver.php)

wuserver: Weather update server in Python

```python
#
#   Weather update server
#   Binds PUB socket to tcp://*:5556
#   Publishes random weather updates
#

import zmq
from random import randrange

context = zmq.Context()
socket = context.socket(zmq.PUB)
socket.bind("tcp://*:5556")

while True:
    zipcode = randrange(1, 100000)
    temperature = randrange(-80, 135)
    relhumidity = randrange(10, 60)

    socket.send_string(f"{zipcode} {temperature} {relhumidity}")
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Python/wuserver.py)

wuserver: Weather update server in Q

The example **wuserver** is missing in **Q**:
[Contribute Translation](https://zguide.zeromq.org/translate)

wuserver: Weather update server in Racket

The example **wuserver** is missing in **Racket**:
[Contribute Translation](https://zguide.zeromq.org/translate)

wuserver: Weather update server in Ruby

The example **wuserver** is missing in **Ruby**:
[Contribute Translation](https://zguide.zeromq.org/translate)

wuserver: Weather update server in Rust

The example **wuserver** is missing in **Rust**:
[Contribute Translation](https://zguide.zeromq.org/translate)

wuserver: Weather update server in Scala

The example **wuserver** is missing in **Scala**:
[Contribute Translation](https://zguide.zeromq.org/translate)

wuserver: Weather update server in Tcl

The example **wuserver** is missing in **Tcl**:
[Contribute Translation](https://zguide.zeromq.org/translate)

wuserver: Weather update server in OCaml

The example **wuserver** is missing in **OCaml**:
[Contribute Translation](https://zguide.zeromq.org/translate)

C \|

C++ \|

C# \|

CL \|

Delphi \|

Erlang \|

Elixir \|

F# \|

Felix \|

Go \|

Haskell \|

Haxe \|

Java \|

Julia \|

Lua \|

Node.js \|

Objective-C \|

Perl \|

PHP \|

Python \|

[Ada \|\\
\\
Basic \|\\
\\
ooc \|\\
\\
Q \|\\
\\
Racket \|\\
\\
Ruby \|\\
\\
Rust \|\\
\\
Scala \|\\
\\
Tcl \|\\
\\
OCaml](https://zguide.zeromq.org/translate)

There’s no start and no end to this stream of updates, it’s like a never ending broadcast.

Here is the client application, which listens to the stream of updates and grabs anything to do with a specified zip code, by default New York City because that’s a great place to start any adventure:

wuclient: Weather update client in Ada

The example **wuclient** is missing in **Ada**:
[Contribute Translation](https://zguide.zeromq.org/translate)

wuclient: Weather update client in Basic

The example **wuclient** is missing in **Basic**:
[Contribute Translation](https://zguide.zeromq.org/translate)

wuclient: Weather update client in C

```c
//  Weather update client
//  Connects SUB socket to tcp://localhost:5556
//  Collects weather updates and finds avg temp in zipcode

#include "zhelpers.h"

int main (int argc, char *argv [])
{
    //  Socket to talk to server
    printf ("Collecting updates from weather server...\n");
    void *context = zmq_ctx_new ();
    void *subscriber = zmq_socket (context, ZMQ_SUB);
    int rc = zmq_connect (subscriber, "tcp://localhost:5556");
    assert (rc == 0);

    //  Subscribe to zipcode, default is NYC, 10001
    const char *filter = (argc > 1)? argv [1]: "10001 ";
    rc = zmq_setsockopt (subscriber, ZMQ_SUBSCRIBE,
                         filter, strlen (filter));
    assert (rc == 0);

    //  Process 100 updates
    int update_nbr;
    long total_temp = 0;
    for (update_nbr = 0; update_nbr < 100; update_nbr++) {
        char *string = s_recv (subscriber);

        int zipcode, temperature, relhumidity;
        sscanf (string, "%d %d %d",
            &zipcode, &temperature, &relhumidity);
        total_temp += temperature;
        free (string);
    }
    printf ("Average temperature for zipcode '%s' was %dF\n",
        filter, (int) (total_temp / update_nbr));

    zmq_close (subscriber);
    zmq_ctx_destroy (context);
    return 0;
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/C/wuclient.c)

wuclient: Weather update client in C++

```c++
//
//  Weather update client in C++
//  Connects SUB socket to tcp://localhost:5556
//  Collects weather updates and finds avg temp in zipcode
//

#include <zmq.hpp>
#include <iostream>
#include <sstream>

int main (int argc, char *argv[])
{
    zmq::context_t context (1);

    //  Socket to talk to server
    std::cout << "Collecting updates from weather server...\n" << std::endl;
    zmq::socket_t subscriber (context, zmq::socket_type::sub);
    subscriber.connect("tcp://localhost:5556");

    //  Subscribe to zipcode, default is NYC, 10001
	const char *filter = (argc > 1)? argv [1]: "10001 ";
    subscriber.set(zmq::sockopt::subscribe, filter);

    //  Process 100 updates
    int update_nbr;
    long total_temp = 0;
    for (update_nbr = 0; update_nbr < 100; update_nbr++) {

        zmq::message_t update;
        int zipcode, temperature, relhumidity;

        subscriber.recv(update, zmq::recv_flags::none);

        std::istringstream iss(static_cast<char*>(update.data()));
		iss >> zipcode >> temperature >> relhumidity ;

		total_temp += temperature;
    }
    std::cout 	<< "Average temperature for zipcode '"<< filter
    			<<"' was "<<(int) (total_temp / update_nbr) <<"F"
    			<< std::endl;
    return 0;
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/C++/wuclient.cpp)

wuclient: Weather update client in C#

```c#
﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;

using ZeroMQ;

namespace Examples
{
	static partial class Program
	{
		public static void WUClient(string[] args)
		{
			//
			// Weather update client
			// Connects SUB socket to tcp://127.0.0.1:5556
			// Collects weather updates and finds avg temp in zipcode
			//
			// Author: metadings
			//

			if (args == null || args.Length < 2)
			{
				Console.WriteLine();
				Console.WriteLine("Usage: ./{0} WUClient [ZipCode] [Endpoint]", AppDomain.CurrentDomain.FriendlyName);
				Console.WriteLine();
				Console.WriteLine("    ZipCode   The zip code to subscribe. Default is 72622 Nürtingen");
				Console.WriteLine("    Endpoint  Where WUClient should connect to.");
				Console.WriteLine("              Default is tcp://127.0.0.1:5556");
				Console.WriteLine();
				if (args.Length < 1)
					args = new string[] { "72622", "tcp://127.0.0.1:5556" };
				else
					args = new string[] { args[0], "tcp://127.0.0.1:5556" };
			}

			string endpoint = args[1];

			// Socket to talk to server
			using (var context = new ZContext())
			using (var subscriber = new ZSocket(context, ZSocketType.SUB))
			{
				string connect_to = args[1];
				Console.WriteLine("I: Connecting to {0}...", connect_to);
				subscriber.Connect(connect_to);

				/* foreach (IPAddress address in WUProxy_GetPublicIPs())
					{
						var epgmAddress = string.Format("epgm://{0};239.192.1.1:8100", address);
						Console.WriteLine("I: Connecting to {0}...", epgmAddress);
						subscriber.Connect(epgmAddress);
					}
				} */

				// Subscribe to zipcode
				string zipCode = args[0];
				Console.WriteLine("I: Subscribing to zip code {0}...", zipCode);
				subscriber.Subscribe(zipCode);

				// Process 10 updates
				int i = 0;
				long total_temperature = 0;
				for (; i < 20; ++i)
				{
					using (var replyFrame = subscriber.ReceiveFrame())
					{
						string reply = replyFrame.ReadString();

						Console.WriteLine(reply);
						total_temperature += Convert.ToInt64(reply.Split(' ')[1]);
					}
				}
				Console.WriteLine("Average temperature for zipcode '{0}' was {1}°", zipCode, (total_temperature / i));
			}
		}
	}
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/CSharp/wuclient.cs)

wuclient: Weather update client in CL

```cl
;;; -*- Mode:Lisp; Syntax:ANSI-Common-Lisp; -*-
;;;
;;;  Weather update client in Common Lisp
;;;  Connects SUB socket to tcp://localhost:5556
;;;  Collects weather updates and finds avg temp in zipcode
;;;
;;; Kamil Shakirov <kamils80@gmail.com>
;;;

(defpackage #:zguide.wuclient
  (:nicknames #:wuclient)
  (:use #:cl #:zhelpers)
  (:export #:main))

(in-package :zguide.wuclient)

(defun main ()
  (zmq:with-context (context 1)
    (message "Collecting updates from weather server...~%")

    ;; Socket to talk to server
    (zmq:with-socket (subscriber context zmq:sub)
      (zmq:connect subscriber "tcp://localhost:5556")

      ;; Subscribe to zipcode, default is NYC, 10001
      (let ((filter (or (first (cmd-args)) "10001 ")))
        (zmq:setsockopt subscriber zmq:subscribe filter)

        ;; Process 100 updates
        (let ((number-updates 100)
              (total-temp 0.0))

          (loop :repeat number-updates :do
            (let ((update (make-instance 'zmq:msg)))
              (zmq:recv subscriber update)

              (destructuring-bind (zipcode_ temperature relhumidity_)
                  (split-sequence:split-sequence #\Space (zmq:msg-data-as-string update))

                (declare (ignore zipcode_ relhumidity_))
                (incf total-temp (parse-integer temperature)))))

          (message "Average temperature for zipcode ~A was ~FF~%"
                   filter (/ total-temp number-updates))))))

  (cleanup))
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/CL/wuclient.lisp)

wuclient: Weather update client in Delphi

```delphi
program wuclient;
//
//  Weather update client
//  Connects SUB socket to tcp://localhost:5556
//  Collects weather updates and finds avg temp in zipcode
//  @author Varga Balazs <bb.varga@gmail.com>
//
{$APPTYPE CONSOLE}

uses
    SysUtils
  , Classes
  , zmqapi
  ;

const
  update_count = 100;

var
  context: TZMQContext;
  subscriber: TZMQSocket;
  filter: String;
  i, total_temp: Integer;
  s: Utf8String;
  tsl: TStringList;
begin
  context := TZMQContext.Create;

  //  Socket to talk to server
  Writeln ( 'Collecting updates from weather server...' );
  subscriber := Context.Socket( stSub );
  subscriber.connect( 'tcp://localhost:5556' );

  //  Subscribe to zipcode, default is NYC, 10001
  if ParamCount > 0 then
    filter := ParamStr( 1 )
  else
    filter := '10001';

  subscriber.subscribe( filter );
  tsl := TStringList.Create;
  tsl.Delimiter := ' ';

  total_temp := 0;
  //  Process 100 updates
  for i := 0 to update_count - 1 do
  begin
    subscriber.recv( s );
    tsl.Clear;
    tsl.DelimitedText := s;
    total_temp := total_temp + StrToInt( tsl[1] );
  end;
  Writeln( Format( 'Average temperature for zipcode "%s" was %fF',
        [ filter, total_temp / update_count]));

  tsl.Free;
  subscriber.Free;
  context.Free;
end.
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Delphi/wuclient.dpr)

wuclient: Weather update client in Erlang

```erlang
#! /usr/bin/env escript
%%
%% Weather update client
%% Connects SUB socket to tcp://localhost:5556
%% Collects weather updates and fins avg temp in zipcode
%%

main(Args) ->
    application:start(chumak),
    {ok, Subscriber} = chumak:socket(sub),

    %% select default topic or from the args
    Topic = case Args of
            [] -> <<"10001">>;
            [Arg1 | _] -> list_to_binary(Arg1)
        end,
    io:format("Collecting updates from weather server...~n"),
    io:format("For zipcode: ~p\n", [Topic]),
    chumak:subscribe(Subscriber, Topic),
    case chumak:connect(Subscriber, tcp, "localhost", 5556) of
        {ok, _BindPid} ->
            io:format("Binding OK with Pid: ~p\n", [Subscriber]);
        {error, Reason} ->
            io:foramt("Connection failed for this reason: ~p\n", [Reason]);
        X ->
            io:format("Unhandled reply for bind ~p \n", [X])
    end,

    N = 10, %% number of records to collect
    TotalTemp = collect_temperature(Subscriber, N, 0),
    io:format("Average Temperature is ~p\n", [TotalTemp/N]).

collect_temperature(_Subscriber, 0, Total) -> Total;
collect_temperature(Subscriber, N, Total) when N > 0 ->
    {ok, Data} = chumak:recv(Subscriber),
    io:format("RECEIVED : ~p\n", [Data]),
    [_, Temp, _] = string:split(Data, " ", all),
    IntTemp = erlang:binary_to_integer(Temp),
    collect_temperature(Subscriber, N-1, Total + IntTemp).
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Erlang/wuclient.es)

wuclient: Weather update client in Elixir

```elixir
defmodule Wuclient do
  @moduledoc """
  Generated by erl2ex (http://github.com/dazuma/erl2ex)
  From Erlang source: (Unknown source file)
  At: 2019-12-20 13:57:39

  """

  def main(args) do
    {:ok, context} = :erlzmq.context()
    :io.format('Collecting updates from weather server...~n')
    {:ok, subscriber} = :erlzmq.socket(context, :sub)
    :ok = :erlzmq.connect(subscriber, 'tcp://localhost:5556')
    filter = case(args) do
      [] ->
        "10001"
      [arg1 | _] ->
        :erlang.list_to_binary(arg1)
    end
    :ok = :erlzmq.setsockopt(subscriber, :subscribe, filter)
    updateNbr = 5
    totalTemp = collect_temperature(subscriber, updateNbr, 0)
    :io.format('Average temperature for zipcode \'~s\' was ~bF~n', [filter, trunc(totalTemp / updateNbr)])
    :ok = :erlzmq.close(subscriber)
    :ok = :erlzmq.term(context)
  end

  def collect_temperature(_subscriber, 0, total) do
    total
  end

  def collect_temperature(subscriber, n, total) when n > 0 do
    {:ok, msg} = :erlzmq.recv(subscriber)
    collect_temperature(subscriber, n - 1, total + msg_temperature(msg))
  end

  def msg_temperature(msg) do
    {:ok, [_, temp, _], _} = :io_lib.fread('~d ~d ~d', :erlang.binary_to_list(msg))
    temp
  end

end

Wuclient.main([])
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Elixir/wuclient.exs)

wuclient: Weather update client in F#

```f#
(*
Weather update client
Connects SUB socket to tcp://localhost:5556
Collects weather updates and finds avg temp in zipcode
*)

#r @"bin/fszmq.dll"
open fszmq

#load "zhelpers.fs"

let main () =
  use context = new Context(1)

  // socket to talk to server
  printfn "Collecting updates from weather server..."
  use subscriber = context |> Context.sub
  Socket.connect subscriber "tcp://localhost:5556"

  // subscribe to zipcode, default is NYC, 10001
  let filter =  if fsi.CommandLineArgs.Length = 2
                  then fsi.CommandLineArgs.[1]
                  else "10001"
  printfn "Listening for updates from: '%s'" filter
  Socket.subscribe subscriber [ encode filter ]

  // process 100 updates
  let update_nbr = ref 0
  let total_temp = ref 0
  while !update_nbr < 100 do
    let update = s_recv subscriber
    let zipcode, temperature, relhumidity =
      let update' = update.Split()
      (int update'.[0]),(int update'.[1]),(int update'.[2])
    total_temp := !total_temp + temperature
    incr update_nbr

  printfn "\nAverage temperature for zipcode '%s' was %dF"
          filter
          (!total_temp / !update_nbr)

  EXIT_SUCCESS

main ()
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/FSharp/wuclient.fsx)

wuclient: Weather update client in Felix

```felix
//
//  Weather update client
//  Connects SUB socket to tcp://localhost:5556
//  Collects weather updates and finds avg temp in zipcode
//
open ZMQ;

fun parse_int(s:string,var i:int) = {
  var acc = 0;
  while s.[i] \in "0123456789" do
    acc = acc * 10 + s.[i].ord - "0".char.ord;
    ++i;
  done
  return i,acc;
}

fun parse_space(s:string, i:int)=> i+1;

fun parse_weather(s:string) = {
  var i = 0;
  def i, val zipcode = parse_int (s,i);
  i = parse_space(s,i);
  def i, val temperature = parse_int (s,i);
  i = parse_space(s,i);
  def i, val relhumidity= parse_int (s,i);
  return zipcode, temperature, relhumidity;
}

var context = zmq_init 1;

//  Socket to talk to server
println "Collecting updates from weather server...";
var subscriber = context.mk_socket ZMQ_SUB;
subscriber.connect "tcp://localhost:5556";

//  Subscribe to zipcode 100
filter := if System::argc > 1 then System::argv 1 else "1001" endif;
subscriber.set_opt$ zmq_subscribe filter;

//  Process 100 updates
var total_temp = 0;
for var update_nbr in 0 upto 99 do
  s := subscriber.recv_string;
  zipcode, temperature, relhumidity := parse_weather s;
  total_temp += temperature;
done
println$
  f"Average temperature for zipcode '%S' was %d C\n"$
  filter, total_temp / update_nbr
;

subscriber.close;
context.term;
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Felix/wuclient.flx)

wuclient: Weather update client in Go

```go
//
//   Weather proxy listens to weather server which is constantly
//   emitting weather data
//   Binds SUB socket to tcp://*:5556
//
package main

import (
	"fmt"
	zmq "github.com/alecthomas/gozmq"
	"os"
	"strconv"
	"strings"
)

func main() {
	context, _ := zmq.NewContext()
	socket, _ := context.NewSocket(zmq.SUB)
	defer context.Close()
	defer socket.Close()

	var temps []string
	var err error
	var temp int64
	total_temp := 0
	filter := "59937"

	// find zipcode
	if len(os.Args) > 1 { // ./wuclient 85678
		filter = string(os.Args[1])
	}

	//  Subscribe to just one zipcode (whitefish MT 59937)
	fmt.Printf("Collecting updates from weather server for %s…\n", filter)
	socket.SetSubscribe(filter)
	socket.Connect("tcp://localhost:5556")

	for i := 0; i < 101; i++ {
		// found temperature point
		datapt, _ := socket.Recv(0)
		temps = strings.Split(string(datapt), " ")
		temp, err = strconv.ParseInt(temps[1], 10, 64)
		if err == nil {
			// Invalid string
			total_temp += int(temp)
		}
	}

	fmt.Printf("Average temperature for zipcode %s was %dF \n\n", filter, total_temp/100)
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Go/wuclient.go)

wuclient: Weather update client in Haskell

```haskell
{-# LANGUAGE LambdaCase          #-}
{-# LANGUAGE OverloadedStrings   #-}
{-# LANGUAGE ScopedTypeVariables #-}

--  Weather update client
--  Connects SUB socket to tcp://localhost:5556
--  Collects weather updates and finds avg temp in zipcode

module Main where

import           Control.Monad
import qualified Data.ByteString.Char8 as BS
import           System.Environment
import           System.ZMQ4.Monadic
import           Text.Printf

main :: IO ()
main = runZMQ $ do
    liftIO $ putStrLn "Collecting updates from weather server..."

    -- Socket to talk to server
    subscriber <- socket Sub
    connect subscriber "tcp://localhost:5556"

    -- Subscribe to zipcode, default is NYC, 10001
    filter <- liftIO getArgs >>= \case
        []          -> return "10001 "
        (zipcode:_) -> return (BS.pack zipcode)
    subscribe subscriber filter

    -- Process 100 updates
    temperature <- fmap sum $
        replicateM 100 $ do
            string <- receive subscriber
            let [_, temperature :: Int, _] = map read . words . BS.unpack $ string
            return temperature

    liftIO $
        printf "Average temperature for zipcode '%s' was %dF"
               (BS.unpack filter)
               (temperature `div` 100)
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Haskell/wuclient.hs)

wuclient: Weather update client in Haxe

```haxe
package ;
import haxe.io.Bytes;
import neko.Lib;
import neko.Sys;
import org.zeromq.ZMQ;
import org.zeromq.ZMQContext;
import org.zeromq.ZMQException;
import org.zeromq.ZMQSocket;

/**
 * Weather update client in Haxe
 * Connects SUB socket to tcp://localhost:5556
 * Collects weather updates and finds average temp in zipcode
 *
 * Use optional argument to specify zip code (in range 1 to 100000)
 *
 * See: http://zguide.zeromq.org/page:all#Getting-the-Message-Out
 *
 * Use with WUServer.hx
 */
class WUClient
{

	public static function main() {
		var context:ZMQContext = ZMQContext.instance();

		Lib.println("** WUClient (see: http://zguide.zeromq.org/page:all#Getting-the-Message-Out)");

		// Socket to talk to server
		trace ("Collecting updates from weather server...");
		var subscriber:ZMQSocket = context.socket(ZMQ_SUB);
		subscriber.setsockopt(ZMQ_LINGER, 0);	 // Don't block when closing socket at end

		subscriber.connect("tcp://localhost:5556");

		// Subscribe to zipcode, default in NYC, 10001
		var filter:String =
			if (Sys.args().length > 0) {
				Sys.args()[0];
			} else {
				"10001";
			};

		try {
			subscriber.setsockopt(ZMQ_SUBSCRIBE, Bytes.ofString(filter));
		} catch (e:ZMQException) {
			trace (e.str());
		}

		// Process 100 updates
		var update_nbr = 0;
		var total_temp:Int = 0;
		for (update_nbr in 0...100) {
			var msg:Bytes = subscriber.recvMsg();
			trace (update_nbr+ ". Received: " + msg.toString());

			var zipcode, temperature, relhumidity;

			var sscanf:Array<String> = msg.toString().split(" ");
			zipcode = sscanf[0];
			temperature = sscanf[1];
			relhumidity = sscanf[2];
			total_temp += Std.parseInt(temperature);

		}
		trace ("Average temperature for zipcode " + filter + " was " + total_temp / 100);

		// Close gracefully
		subscriber.close();
		context.term();
	}
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Haxe/wuclient.hx)

wuclient: Weather update client in Java

```java
package guide;

import java.util.StringTokenizer;

import org.zeromq.SocketType;
import org.zeromq.ZMQ;
import org.zeromq.ZContext;

//
//  Weather update client in Java
//  Connects SUB socket to tcp://localhost:5556
//  Collects weather updates and finds avg temp in zipcode
//
public class wuclient
{
    public static void main(String[] args)
    {
        try (ZContext context = new ZContext()) {
            //  Socket to talk to server
            System.out.println("Collecting updates from weather server");
            ZMQ.Socket subscriber = context.createSocket(SocketType.SUB);
            subscriber.connect("tcp://localhost:5556");

            //  Subscribe to zipcode, default is NYC, 10001
            String filter = (args.length > 0) ? args[0] : "10001 ";
            subscriber.subscribe(filter.getBytes(ZMQ.CHARSET));

            //  Process 100 updates
            int update_nbr;
            long total_temp = 0;
            for (update_nbr = 0; update_nbr < 100; update_nbr++) {
                //  Use trim to remove the tailing '0' character
                String string = subscriber.recvStr(0).trim();

                StringTokenizer sscanf = new StringTokenizer(string, " ");
                int zipcode = Integer.valueOf(sscanf.nextToken());
                int temperature = Integer.valueOf(sscanf.nextToken());
                int relhumidity = Integer.valueOf(sscanf.nextToken());

                total_temp += temperature;
            }

            System.out.println(
                String.format(
                    "Average temperature for zipcode '%s' was %d.",
                    filter,
                    (int)(total_temp / update_nbr)
                )
            );
        }
    }
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Java/wuclient.java)

wuclient: Weather update client in Julia

```julia
#!/usr/bin/env julia

#
#   Weather update client
#   Connects SUB socket to tcp://localhost:5556
#   Collects weather updates and finds avg temp in zipcode
#

using ZMQ

context = Context()
socket = Socket(context, SUB)

println("Collecting updates from weather server...")
connect(socket, "tcp://localhost:5556")

# Subscribe to zipcode, default is NYC, 10001
zip_filter = length(ARGS) > 0 ? int(ARGS[1]) : 10001

subscribe(socket, string(zip_filter))

# Process 5 updates
update_nbr = 5

total_temp = 0
for update in 1:update_nbr
    global total_temp
    message = unsafe_string(recv(socket))
    zipcode, temperature, relhumidity = split(message)
    total_temp += parse(Int, temperature)
end

avg_temp = total_temp / update_nbr

println("Average temperature for zipcode $zip_filter was $(avg_temp)F")

# Making a clean exit.
close(socket)
close(context)
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Julia/wuclient.jl)

wuclient: Weather update client in Lua

```lua
--
--  Weather update client
--  Connects SUB socket to tcp://localhost:5556
--  Collects weather updates and finds avg temp in zipcode
--
--  Author: Robert G. Jakabosky <bobby@sharedrealm.com>
--
require"zmq"

local context = zmq.init(1)

--  Socket to talk to server
print("Collecting updates from weather server...")
local subscriber = context:socket(zmq.SUB)
subscriber:connect(arg[2] or "tcp://localhost:5556")

--  Subscribe to zipcode, default is NYC, 10001
local filter = arg[1] or "10001 "
subscriber:setopt(zmq.SUBSCRIBE, filter)

--  Process 100 updates
local update_nbr = 0
local total_temp = 0
for n=1,100 do
    local message = subscriber:recv()
    local zipcode, temperature, relhumidity = message:match("([%d-]*) ([%d-]*) ([%d-]*)")
    total_temp = total_temp + temperature
    update_nbr = update_nbr + 1
end
print(string.format("Average temperature for zipcode '%s' was %dF, total = %d",
    filter, (total_temp / update_nbr), total_temp))

subscriber:close()
context:term()
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Lua/wuclient.lua)

wuclient: Weather update client in Node.js

```node.js
// weather update client in node.js
// connects SUB socket to tcp://localhost:5556
// collects weather updates and finds avg temp in zipcode

var zmq = require('zeromq');

console.log("Collecting updates from weather server...");

// Socket to talk to server
var subscriber = zmq.socket('sub');

// Subscribe to zipcode, default is NYC, 10001
var filter = null;
if (process.argv.length > 2) {
  filter = process.argv[2];
} else {
  filter = "10001";
}
console.log(filter);
subscriber.subscribe(filter);

// process 100 updates
var total_temp = 0
  , temps      = 0;
subscriber.on('message', function(data) {
  var pieces      = data.toString().split(" ")
    , zipcode     = parseInt(pieces[0], 10)
    , temperature = parseInt(pieces[1], 10)
    , relhumidity = parseInt(pieces[2], 10);

  temps += 1;
  total_temp += temperature;

  if (temps === 100) {
    console.log([\
      "Average temperature for zipcode '",\
      filter,\
      "' was ",\
      (total_temp / temps).toFixed(2),\
      " F"].join(""));
    total_temp = 0;
    temps = 0;
  }
});

subscriber.connect("tcp://localhost:5556");
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Node.js/wuclient.js)

wuclient: Weather update client in Objective-C

```objective-c
//
//  Weather update client
//  Connects SUB socket to tcp://localhost:5556
//  Collects weather updates and finds avg temp in zipcode
//
#import "ZMQObjC.h"

int
main(int argc, const char *argv[])
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	ZMQContext *ctx = [[[ZMQContext alloc] initWithIOThreads:1U] autorelease];

	// Socket to talk to server
	ZMQSocket *subscriber = [ctx socketWithType:ZMQ_SUB];
	if (![subscriber connectToEndpoint:@"tcp://localhost:5556"]) {
		/* ZMQSocket will already have logged the error. */
		return EXIT_FAILURE;
	}

	/* Subscribe to zipcode (defaults to NYC, 10001). */
	const char *kNYCZipCode = "10001";
	const char *filter = (argc > 1)? argv[1] : kNYCZipCode;
	NSData *filterData = [NSData dataWithBytes:filter length:strlen(filter)];
	[subscriber setData:filterData forOption:ZMQ_SUBSCRIBE];

	/* Write to stdout immediately rather than at each newline.
	 * This makes the incremental temperatures appear incrementally.
	 */
	(void)setvbuf(stdout, NULL, _IONBF, BUFSIZ);

	/* Process updates. */
	NSLog(@"Collecting temperatures for zipcode %s from weather server...", filter);
	const int kMaxUpdate = 100;
	long total_temp = 0;
	for (int update_nbr = 0; update_nbr < kMaxUpdate; ++update_nbr) {
		NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

		NSData *msg = [subscriber receiveDataWithFlags:0];
		const char *string = [msg bytes];

		int zipcode = 0, temperature = 0, relhumidity = 0;
		(void)sscanf(string, "%d %d %d", &zipcode, &temperature, &relhumidity);

		printf("%d ", temperature);
		total_temp += temperature;

		[pool drain];
	}
	/* End line of temperatures. */
	putchar('\n');

	NSLog(@"Average temperature for zipcode '%s' was %ld degF.",
			filter, total_temp / kMaxUpdate);

	/* [ZMQContext sockets] makes it easy to close all associated sockets. */
	[[ctx sockets] makeObjectsPerformSelector:@selector(close)];
	[pool drain];
	return EXIT_SUCCESS;
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Objective-C/wuclient.m)

wuclient: Weather update client in ooc

The example **wuclient** is missing in **ooc**:
[Contribute Translation](https://zguide.zeromq.org/translate)

wuclient: Weather update client in Perl

```perl
# Weather update client in Perl
# Connects SUB socket to tcp://localhost:5556
# Collects weather updates and finds avg temp in zipcode

use strict;
use warnings;
use v5.10;

use ZMQ::FFI;
use ZMQ::FFI::Constants qw(ZMQ_SUB);

# Socket to talk to server
say "Collecting updates from weather station...";

my $context    = ZMQ::FFI->new();
my $subscriber = $context->socket(ZMQ_SUB);
$subscriber->connect("tcp://localhost:5556");

# Subscribe to zipcode, default is NYC, 10001
my $filter = $ARGV[0] // "10001";
$subscriber->subscribe($filter);

# Process 100 updates
my $update_nbr = 100;
my $total_temp = 0;

my ($update, $zipcode, $temperature, $relhumidity);

for (1..$update_nbr) {
    $update = $subscriber->recv();

    ($zipcode, $temperature, $relhumidity) = split ' ', $update;
    $total_temp += $temperature;
}

printf "Average temperature for zipcode '%s' was %dF\n",
    $filter, $total_temp / $update_nbr;
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Perl/wuclient.pl)

wuclient: Weather update client in PHP

```php
<?php
/*
 *  Weather update client
 *  Connects SUB socket to tcp://localhost:5556
 *  Collects weather updates and finds avg temp in zipcode
 * @author Ian Barber <ian(dot)barber(at)gmail(dot)com>
 */

$context = new ZMQContext();

//  Socket to talk to server
echo "Collecting updates from weather server...", PHP_EOL;
$subscriber = new ZMQSocket($context, ZMQ::SOCKET_SUB);
$subscriber->connect("tcp://localhost:5556");

//  Subscribe to zipcode, default is NYC, 10001
$filter = $_SERVER['argc'] > 1 ? $_SERVER['argv'][1] : "10001";
$subscriber->setSockOpt(ZMQ::SOCKOPT_SUBSCRIBE, $filter);

//  Process 100 updates
$total_temp = 0;
for ($update_nbr = 0; $update_nbr < 100; $update_nbr++) {
    $string = $subscriber->recv();
    sscanf ($string, "%d %d %d", $zipcode, $temperature, $relhumidity);
    $total_temp += $temperature;
}
printf ("Average temperature for zipcode '%s' was %dF\n",
    $filter, (int) ($total_temp / $update_nbr));
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/PHP/wuclient.php)

wuclient: Weather update client in Python

```python
#
#   Weather update client
#   Connects SUB socket to tcp://localhost:5556
#   Collects weather updates and finds avg temp in zipcode
#

import sys
import zmq

#  Socket to talk to server
context = zmq.Context()
socket = context.socket(zmq.SUB)

print("Collecting updates from weather server...")
socket.connect("tcp://localhost:5556")

# Subscribe to zipcode, default is NYC, 10001
zip_filter = sys.argv[1] if len(sys.argv) > 1 else "10001"
socket.setsockopt_string(zmq.SUBSCRIBE, zip_filter)

# Process 100 updates
total_temp = 0
for update_nbr in range(100):
    string = socket.recv_string()
    zipcode, temperature, relhumidity = string.split()
    total_temp += int(temperature)

print((f"Average temperature for zipcode "
    f"'{zip_filter}' was {total_temp / (update_nbr+1)} F"))
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Python/wuclient.py)

wuclient: Weather update client in Q

The example **wuclient** is missing in **Q**:
[Contribute Translation](https://zguide.zeromq.org/translate)

wuclient: Weather update client in Racket

The example **wuclient** is missing in **Racket**:
[Contribute Translation](https://zguide.zeromq.org/translate)

wuclient: Weather update client in Ruby

The example **wuclient** is missing in **Ruby**:
[Contribute Translation](https://zguide.zeromq.org/translate)

wuclient: Weather update client in Rust

The example **wuclient** is missing in **Rust**:
[Contribute Translation](https://zguide.zeromq.org/translate)

wuclient: Weather update client in Scala

The example **wuclient** is missing in **Scala**:
[Contribute Translation](https://zguide.zeromq.org/translate)

wuclient: Weather update client in Tcl

The example **wuclient** is missing in **Tcl**:
[Contribute Translation](https://zguide.zeromq.org/translate)

wuclient: Weather update client in OCaml

The example **wuclient** is missing in **OCaml**:
[Contribute Translation](https://zguide.zeromq.org/translate)

C \|

C++ \|

C# \|

CL \|

Delphi \|

Erlang \|

Elixir \|

F# \|

Felix \|

Go \|

Haskell \|

Haxe \|

Java \|

Julia \|

Lua \|

Node.js \|

Objective-C \|

Perl \|

PHP \|

Python \|

[Ada \|\\
\\
Basic \|\\
\\
ooc \|\\
\\
Q \|\\
\\
Racket \|\\
\\
Ruby \|\\
\\
Rust \|\\
\\
Scala \|\\
\\
Tcl \|\\
\\
OCaml](https://zguide.zeromq.org/translate)**Figure 4 - Publish-Subscribe**

![](https://zguide.zeromq.org/images/fig4.png)

Note that when you use a SUB socket you **must** set a subscription using `
[zmq\_setsockopt()](http://api.zeromq.org/master:zmq_setsockopt)` and SUBSCRIBE, as in this code. If you don’t set any subscription, you won’t get any messages. It’s a common mistake for beginners. The subscriber can set many subscriptions, which are added together. That is, if an update matches ANY subscription, the subscriber receives it. The subscriber can also cancel specific subscriptions. A subscription is often, but not always, a printable string. See `
[zmq\_setsockopt()](http://api.zeromq.org/master:zmq_setsockopt)` for how this works.

The PUB-SUB socket pair is asynchronous. The client does `
[zmq\_recv()](http://api.zeromq.org/master:zmq_recv)`, in a loop (or once if that’s all it needs). Trying to send a message to a SUB socket will cause an error. Similarly, the service does `
[zmq\_send()](http://api.zeromq.org/master:zmq_send)` as often as it needs to, but must not do `
[zmq\_recv()](http://api.zeromq.org/master:zmq_recv)` on a PUB socket.

In theory with ZeroMQ sockets, it does not matter which end connects and which end binds. However, in practice there are undocumented differences that I’ll come to later. For now, bind the PUB and connect the SUB, unless your network design makes that impossible.

There is one more important thing to know about PUB-SUB sockets: you do not know precisely when a subscriber starts to get messages. Even if you start a subscriber, wait a while, and then start the publisher, **the subscriber will always miss the first messages that the publisher sends**. This is because as the subscriber connects to the publisher (something that takes a small but non-zero time), the publisher may already be sending messages out.

This “slow joiner” symptom hits enough people often enough that we’re going to explain it in detail. Remember that ZeroMQ does asynchronous I/O, i.e., in the background. Say you have two nodes doing this, in this order:

- Subscriber connects to an endpoint and receives and counts messages.
- Publisher binds to an endpoint and immediately sends 1,000 messages.

Then the subscriber will most likely not receive anything. You’ll blink, check that you set a correct filter and try again, and the subscriber will still not receive anything.

Making a TCP connection involves to and from handshaking that takes several milliseconds depending on your network and the number of hops between peers. In that time, ZeroMQ can send many messages. For sake of argument assume it takes 5 msecs to establish a connection, and that same link can handle 1M messages per second. During the 5 msecs that the subscriber is connecting to the publisher, it takes the publisher only 1 msec to send out those 1K messages.

In
[Chapter 2 - Sockets and Patterns](https://zguide.zeromq.org/docs/chapter2/#sockets-and-patterns) we’ll explain how to synchronize a publisher and subscribers so that you don’t start to publish data until the subscribers really are connected and ready. There is a simple and stupid way to delay the publisher, which is to sleep. Don’t do this in a real application, though, because it is extremely fragile as well as inelegant and slow. Use sleeps to prove to yourself what’s happening, and then wait for
[Chapter 2 - Sockets and Patterns](https://zguide.zeromq.org/docs/chapter2/#sockets-and-patterns) to see how to do this right.

The alternative to synchronization is to simply assume that the published data stream is infinite and has no start and no end. One also assumes that the subscriber doesn’t care what transpired before it started up. This is how we built our weather client example.

So the client subscribes to its chosen zip code and collects 100 updates for that zip code. That means about ten million updates from the server, if zip codes are randomly distributed. You can start the client, and then the server, and the client will keep working. You can stop and restart the server as often as you like, and the client will keep working. When the client has collected its hundred updates, it calculates the average, prints it, and exits.

Some points about the publish-subscribe (pub-sub) pattern:

- A subscriber can connect to more than one publisher, using one connect call each time. Data will then arrive and be interleaved (“fair-queued”) so that no single publisher drowns out the others.

- If a publisher has no connected subscribers, then it will simply drop all messages.

- If you’re using TCP and a subscriber is slow, messages will queue up on the publisher. We’ll look at how to protect publishers against this using the “high-water mark” later.

- From ZeroMQ v3.x, filtering happens at the publisher side when using a connected protocol ( `tcp:@<>@` _or `ipc:@<`_  `>@`). Using the `epgm:@<//>@` protocol, filtering happens at the subscriber side. In ZeroMQ v2.x, all filtering happened at the subscriber side.


This is how long it takes to receive and filter 10M messages on my laptop, which is an 2011-era Intel i5, decent but nothing special:

```
$ time wuclient
Collecting updates from weather server...
Average temperature for zipcode '10001 ' was 28F

real    0m4.470s
user    0m0.000s
sys     0m0.008s
```

## Divide and Conquer  [\#](https://zguide.zeromq.org/docs/chapter1/\#Divide-and-Conquer)

**Figure 5 - Parallel Pipeline**

![](https://zguide.zeromq.org/images/fig5.png)

As a final example (you are surely getting tired of juicy code and want to delve back into philological discussions about comparative abstractive norms), let’s do a little supercomputing. Then coffee. Our supercomputing application is a fairly typical parallel processing model. We have:

- A ventilator that produces tasks that can be done in parallel
- A set of workers that process tasks
- A sink that collects results back from the worker processes

In reality, workers run on superfast boxes, perhaps using GPUs (graphic processing units) to do the hard math. Here is the ventilator. It generates 100 tasks, each a message telling the worker to sleep for some number of milliseconds:

taskvent: Parallel task ventilator in Ada

The example **taskvent** is missing in **Ada**:
[Contribute Translation](https://zguide.zeromq.org/translate)

taskvent: Parallel task ventilator in Basic

The example **taskvent** is missing in **Basic**:
[Contribute Translation](https://zguide.zeromq.org/translate)

taskvent: Parallel task ventilator in C

```c
//  Task ventilator
//  Binds PUSH socket to tcp://localhost:5557
//  Sends batch of tasks to workers via that socket

#include "zhelpers.h"

int main (void)
{
    void *context = zmq_ctx_new ();

    //  Socket to send messages on
    void *sender = zmq_socket (context, ZMQ_PUSH);
    zmq_bind (sender, "tcp://*:5557");

    //  Socket to send start of batch message on
    void *sink = zmq_socket (context, ZMQ_PUSH);
    zmq_connect (sink, "tcp://localhost:5558");

    printf ("Press Enter when the workers are ready: ");
    getchar ();
    printf ("Sending tasks to workers...\n");

    //  The first message is "0" and signals start of batch
    s_send (sink, "0");

    //  Initialize random number generator
    srandom ((unsigned) time (NULL));

    //  Send 100 tasks
    int task_nbr;
    int total_msec = 0;     //  Total expected cost in msecs
    for (task_nbr = 0; task_nbr < 100; task_nbr++) {
        int workload;
        //  Random workload from 1 to 100msecs
        workload = randof (100) + 1;
        total_msec += workload;
        char string [10];
        sprintf (string, "%d", workload);
        s_send (sender, string);
    }
    printf ("Total expected cost: %d msec\n", total_msec);

    zmq_close (sink);
    zmq_close (sender);
    zmq_ctx_destroy (context);
    return 0;
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/C/taskvent.c)

taskvent: Parallel task ventilator in C++

```c++
//
//  Task ventilator in C++
//  Binds PUSH socket to tcp://localhost:5557
//  Sends batch of tasks to workers via that socket
//

#include <zmq.hpp>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <iostream>

#define within(num) (int) ((float) num * random () / (RAND_MAX + 1.0))

int main (int argc, char *argv[])
{
    zmq::context_t context (1);

    //  Socket to send messages on
    zmq::socket_t  sender(context, ZMQ_PUSH);
    sender.bind("tcp://*:5557");

    std::cout << "Press Enter when the workers are ready: " << std::endl;
    getchar ();
    std::cout << "Sending tasks to workers...\n" << std::endl;

    //  The first message is "0" and signals start of batch
    zmq::socket_t sink(context, ZMQ_PUSH);
    sink.connect("tcp://localhost:5558");
    zmq::message_t message(2);
    memcpy(message.data(), "0", 1);
    sink.send(message);

    //  Initialize random number generator
    srandom ((unsigned) time (NULL));

    //  Send 100 tasks
    int task_nbr;
    int total_msec = 0;     //  Total expected cost in msecs
    for (task_nbr = 0; task_nbr < 100; task_nbr++) {
        int workload;
        //  Random workload from 1 to 100msecs
        workload = within (100) + 1;
        total_msec += workload;

        message.rebuild(10);
        memset(message.data(), '\0', 10);
        sprintf ((char *) message.data(), "%d", workload);
        sender.send(message);
    }
    std::cout << "Total expected cost: " << total_msec << " msec" << std::endl;
    sleep (1);              //  Give 0MQ time to deliver

    return 0;
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/C++/taskvent.cpp)

taskvent: Parallel task ventilator in C#

```c#
﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;

using ZeroMQ;

namespace Examples
{
	static partial class Program
	{
		public static void TaskVent(string[] args)
		{
			//
			// Task ventilator
			// Binds PUSH socket to tcp://127.0.0.1:5557
			// Sends batch of tasks to workers via that socket
			//
			// Author: metadings
			//

			// Socket to send messages on and
			// Socket to send start of batch message on
			using (var context = new ZContext())
			using (var sender = new ZSocket(context, ZSocketType.PUSH))
			using (var sink = new ZSocket(context, ZSocketType.PUSH))
			{
				sender.Bind("tcp://*:5557");
				sink.Connect("tcp://127.0.0.1:5558");

				Console.WriteLine("Press ENTER when the workers are ready...");
				Console.ReadKey(true);
				Console.WriteLine("Sending tasks to workers...");

				// The first message is "0" and signals start of batch
				sink.Send(new byte[] { 0x00 }, 0, 1);

				// Initialize random number generator
				var rnd = new Random();

				// Send 100 tasks
				int i = 0;
				long total_msec = 0;	// Total expected cost in msecs
				for (; i < 100; ++i)
				{
					// Random workload from 1 to 100msecs
					int workload = rnd.Next(100) + 1;
					total_msec += workload;
					byte[] action = BitConverter.GetBytes(workload);

					Console.WriteLine("{0}", workload);
					sender.Send(action, 0, action.Length);
				}

				Console.WriteLine("Total expected cost: {0} ms", total_msec);
			}
		}
	}
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/CSharp/taskvent.cs)

taskvent: Parallel task ventilator in CL

```cl
;;; -*- Mode:Lisp; Syntax:ANSI-Common-Lisp; -*-
;;;
;;;  Task ventilator in Common Lisp
;;;  Binds PUSH socket to tcp://localhost:5557
;;;  Sends batch of tasks to workers via that socket
;;;
;;; Kamil Shakirov <kamils80@gmail.com>
;;;

(defpackage #:zguide.taskvent
  (:nicknames #:taskvent)
  (:use #:cl #:zhelpers)
  (:export #:main))

(in-package :zguide.taskvent)

(defun main ()
  (zmq:with-context (context 1)
    ;; Socket to send messages on
    (zmq:with-socket (sender context zmq:push)
      (zmq:bind sender "tcp://*:5557")

      (message "Press Enter when the workers are ready: ")
      (read-char)
      (message "Sending tasks to workers...~%")

      ;; The first message is "0" and signals start of batch
      (let ((msg (make-instance 'zmq:msg :data "0")))
        (zmq:send sender msg))

      ;; Send 100 tasks
      (let ((total-msec 0))
        (loop :repeat 100 :do
          ;; Random workload from 1 to 100 msecs
          (let ((workload (within 100)))
            (incf total-msec workload)
            (let ((msg (make-instance 'zmq:msg
                                      :data (format nil "~D" workload))))
              (zmq:send sender msg))))

        (message "Total expected cost: ~D msec~%" total-msec)
        ;; Give 0MQ time to deliver
        (sleep 1))))

  (cleanup))
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/CL/taskvent.lisp)

taskvent: Parallel task ventilator in Delphi

```delphi
program taskvent;
//
//  Task ventilator
//  Binds PUSH socket to tcp://localhost:5557
//  Sends batch of tasks to workers via that socket
//  @author Varga Balazs <bb.varga@gmail.com>
//
{$APPTYPE CONSOLE}

uses
    SysUtils
  , zmqapi
  ;

const
  task_count = 100;

var
  context: TZMQContext;
  sender,
  sink: TZMQSocket;
  s: String;
  i,
  total_msec,
  workload: Integer;

begin
  context := TZMQContext.Create;

  //  Socket to send messages on
  sender := Context.Socket( stPush );
  sender.bind( 'tcp://*:5557' );

  //  Socket to send start of batch message on
  sink := Context.Socket( stPush );
  sink.connect( 'tcp://localhost:5558' );

  Write( 'Press Enter when the workers are ready: ' );
  Readln( s );
  Writeln( 'Sending tasks to workers...' );

  //  The first message is "0" and signals start of batch
  sink.send( '0' );

  //  Initialize random number generator
  randomize;

  //  Send 100 tasks
  total_msec := 0; //  Total expected cost in msecs
  for i := 0 to task_count - 1 do
  begin
    //  Random workload from 1 to 100msecs
    workload := Random( 100 ) + 1;
    total_msec := total_msec + workload;

    s := IntToStr( workload );
    sender.send( s );
  end;
  Writeln( Format( 'Total expected cost: %d msec', [total_msec] ) );
  sleep(1000); //  Give 0MQ time to deliver

  sink.Free;
  sender.Free;
  Context.Free;
end.
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Delphi/taskvent.dpr)

taskvent: Parallel task ventilator in Erlang

```erlang
#! /usr/bin/env escript
%%
%% Task ventilator
%% Binds PUSH socket to tcp://localhost:5557
%% Sends batch of tasks to workers via that socket
%%
main(_Args) ->
    application:start(chumak),
    {ok, Sender} = chumak:socket(push),

    case chumak:bind(Sender, tcp, "*", 5557) of
        {ok, _BindPid} ->
            io:format("Binding OK with Pid: ~p\n", [Sender]);
        {error, Reason} ->
            io:format("Connection Failed for this reason: ~p\n", [Reason]);
        X ->
            io:format("Unhandled reply for bind ~p\n", [X])
    end,

    {ok, Sink} = chumak:socket(push),

    case chumak:connect(Sink, tcp, "localhost", 5558) of
        {ok, _ConnectPid} ->
            io:format("Connection OK with Pid: ~p\n", [Sink]);
        {error, Reason2} ->
            io:format("Connection Failed for this reason: ~p\n", [Reason2]);
        X2 ->
            io:format("Unhandled reply for connect  ~p\n", [X2])
    end,

    {ok, _} = io:fread("Press Enter when workers are ready: ", ""),
    io:format("Sending task to workers~n", []),

    ok = chumak:send(Sink, <<"0">>),

    %% Send 100 tasks
    TotalCost = send_tasks(Sender, 100, 0),
    io:format("Total expected cost: ~b msec~n", [TotalCost]).

send_tasks(_Sender, 0, TotalCost) -> TotalCost;
send_tasks(Sender, N, TotalCost) when N>0 ->
    Workload = rand:uniform(100) + 1,
    ok = chumak:send(Sender, list_to_binary(integer_to_list(Workload))),
    send_tasks(Sender, N-1, TotalCost + Workload).
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Erlang/taskvent.es)

taskvent: Parallel task ventilator in Elixir

```elixir
defmodule Taskvent do
  @moduledoc """
  Generated by erl2ex (http://github.com/dazuma/erl2ex)
  From Erlang source: (Unknown source file)
  At: 2019-12-20 13:57:36

  """

  def main() do
    {:ok, context} = :erlzmq.context()
    {:ok, sender} = :erlzmq.socket(context, :push)
    :ok = :erlzmq.bind(sender, 'tcp://*:5557')
    {:ok, sink} = :erlzmq.socket(context, :push)
    :ok = :erlzmq.connect(sink, 'tcp://localhost:5558')
    {:ok, _} = :io.fread('Press Enter when workers are ready: ', [])
    :io.format('Sending task to workers~n', [])
    :ok = :erlzmq.send(sink, "0")
    totalCost = send_tasks(sender, 100, 0)
    :io.format('Total expected cost: ~b msec~n', [totalCost])
    :ok = :erlzmq.close(sink)
    :ok = :erlzmq.close(sender)
    :erlzmq.term(context, 1000)
  end

  def send_tasks(_sender, 0, totalCost) do
    totalCost
  end

  def send_tasks(sender, n, totalCost) when n > 0 do
    workload = :random.uniform(100) + 1
    :ok = :erlzmq.send(sender, :erlang.list_to_binary(:erlang.integer_to_list(workload)))
    send_tasks(sender, n - 1, totalCost + workload)
  end

end

Taskvent.main
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Elixir/taskvent.exs)

taskvent: Parallel task ventilator in F#

```f#
(*
Task ventilator
Binds PUSH socket to tcp://localhost:5557
Sends batch of tasks to workers via that socket
*)
#r @"bin/fszmq.dll"
open fszmq

#load "zhelpers.fs"

let main () =
  use context = new Context(1)

  // Socket to send messages on
  use sender = context |> Context.push
  Socket.bind sender "tcp://*:5557"

  // Socket to send start of batch message on
  use sink = context |> Context.push
  Socket.connect sink "tcp://localhost:5558"

  printf "Press Enter when workers are ready: "
  scanln() |> ignore
  printfn "Sending tasks to workers"

  // The first message is "0" and signals start of batch
  s_send sink "0"

  // Initialize random number generator
  let rnd = srandom()

  // Send 100 tasks
  let mutable total_msec = 0
  for task_nbr in 0 .. 99 do
    // Random workload from 1 to 100 msecs
    let workload = (rnd.Next 100) + 1
    total_msec <- total_msec + workload
    s_send sender (string workload)

  printfn "Total expected cost: %d msec" total_msec
  sleep 1 // Give 0MQ time to deliver

  EXIT_SUCCESS

main ()
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/FSharp/taskvent.fsx)

taskvent: Parallel task ventilator in Felix

```felix
//
//  Task ventilator
//  Binds PUSH socket to tcp://localhost:5557
//  Sends batch of tasks to workers via that socket

open ZMQ;

var context = zmq_init 1;

//  Socket to send messages on
var sender = context.mk_socket ZMQ_PUSH;
sender.bind "tcp://*:5557";

//  Socket to send start of batch message on
var sink = context.mk_socket ZMQ_PUSH;
sink.connect "tcp://localhost:5558";

print ("Press Enter when the workers are ready: "); fflush;
C_hack::ignore (readln stdin);
println "Sending tasks to workers...";

//  The first message is "0" and signals start of batch
sink.send_string "0";

//  Send 100 tasks
var total_msec = 0;     //  Total expected cost in msecs
for var task_nbr in 0 upto 99 do
  //  Random workload from 1 to 100msecs
  var workload = #rand % 100 + 1;
  total_msec += workload;
  var s = f"%d" workload;
  sender.send_string s;
done
println$ f"Total expected cost: %d msec" total_msec;
Faio::sleep (sys_clock, 1.0);              //  Give 0MQ time to deliver

sink.close;
sender.close;
context.term;
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Felix/taskvent.flx)

taskvent: Parallel task ventilator in Go

```go
//
// Task ventilator
// Binds PUSH socket to tcp://localhost:5557
// Sends batch of tasks to workers via that socket
//
package main

import (
	"fmt"
	zmq "github.com/alecthomas/gozmq"
	"math/rand"
	"time"
)

func main() {
	context, _ := zmq.NewContext()
	defer context.Close()

	// Socket to send messages On
	sender, _ := context.NewSocket(zmq.PUSH)
	defer sender.Close()
	sender.Bind("tcp://*:5557")

	//  Socket to send start of batch message on
	sink, _ := context.NewSocket(zmq.PUSH)
	defer sink.Close()
	sink.Connect("tcp://localhost:5558")

	fmt.Print("Press Enter when the workers are ready: ")

	var line string
	fmt.Scanln(&line)

	fmt.Println("Sending tasks to workers…")

	sink.Send([]byte("0"), 0)

	// Seed the random number generator
	rand.Seed(time.Now().UnixNano())

	total_msec := 0

	for i := 0; i < 100; i++ {
		workload := rand.Intn(100)
		total_msec += workload
		msg := fmt.Sprintf("%d", workload)
		sender.Send([]byte(msg), 0)
	}

	fmt.Printf("Total expected cost: %d msec\n", total_msec)

	time.Sleep(1e9) //  Give 0MQ time to deliver: one second ==  1e9 ns

}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Go/taskvent.go)

taskvent: Parallel task ventilator in Haskell

```haskell
{-# LANGUAGE OverloadedStrings   #-}
{-# LANGUAGE ScopedTypeVariables #-}

--  Task ventilator
--  Binds PUSH socket to tcp://localhost:5557
--  Sends batch of tasks to workers via that socket

module Main where

import           Control.Monad
import qualified Data.ByteString.Char8 as BS
import           System.ZMQ4.Monadic
import           System.Random

main :: IO ()
main = runZMQ $ do
    -- Socket to send messages on
    sender <- socket Push
    bind sender "tcp://*:5557"

    -- Socket to send start of batch message on
    sink <- socket Push
    connect sink "tcp://localhost:5558"

    liftIO $ do
        putStrLn "Press Enter when the workers are ready: "
        _ <- getLine
        putStrLn "Sending tasks to workers..."

    -- The first message is "0" and signals start of batch
    send sink [] "0"

    -- Send 100 tasks
    total_msec <- fmap sum $
        replicateM 100 $ do
            -- Random workload from 1 to 100msecs
            workload :: Int <- liftIO $ randomRIO (1, 100)
            send sender [] $ BS.pack (show workload)
            return workload

    liftIO . putStrLn $ "Total expected cost: " ++ show total_msec ++ " msec"
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Haskell/taskvent.hs)

taskvent: Parallel task ventilator in Haxe

```haxe
package ;

import haxe.io.Bytes;
import haxe.Stack;
import neko.Lib;
import neko.io.File;
import neko.io.FileInput;
import neko.Sys;
import org.zeromq.ZMQ;
import org.zeromq.ZMQContext;
import org.zeromq.ZMQException;
import org.zeromq.ZMQSocket;

/**
 * Task ventilator in Haxe
 * Binds PUSH socket to tcp://localhost:5557
 * Sends batch of tasks to workers via that socket.
 *
 * Based on code from: http://zguide.zeromq.org/java:taskvent
 *
 * Use with TaskWork.hx and TaskSink.hx
 */
class TaskVent
{

	public static function main() {

		try {
			var context:ZMQContext = ZMQContext.instance();
			var sender:ZMQSocket = context.socket(ZMQ_PUSH);

			Lib.println("** TaskVent (see: http://zguide.zeromq.org/page:all#Divide-and-Conquer)");

			sender.bind("tcp://127.0.0.1:5557");

			Lib.println("Press Enter when the workers are ready: ");
			var f:FileInput = File.stdin();
			var str:String = f.readLine();
			Lib.println("Sending tasks to workers ...\n");

			// The first message is "0" and signals starts of batch
			sender.sendMsg(Bytes.ofString("0"));

			// Send 100 tasks
			var totalMsec:Int = 0;		// Total expected cost in msec
			for (task_nbr in 0 ... 100) {
				var workload = Std.random(100) + 1;	// Generates 1 to 100 msecs
				totalMsec += workload;
				Lib.print(workload + ".");
				sender.sendMsg(Bytes.ofString(Std.string(workload)));
			}
			Lib.println("Total expected cost: " + totalMsec + " msec");

			// Give 0MQ time to deliver
			Sys.sleep(1);

			sender.close();
			context.term();
		} catch (e:ZMQException) {
			trace("ZMQException #:" + ZMQ.errNoToErrorType(e.errNo) + ", str:" + e.str());
			trace (Stack.toString(Stack.exceptionStack()));

		}
	}
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Haxe/taskvent.hx)

taskvent: Parallel task ventilator in Java

```java
package guide;

import java.util.Random;

import org.zeromq.SocketType;
import org.zeromq.ZMQ;
import org.zeromq.ZContext;

//
//  Task ventilator in Java
//  Binds PUSH socket to tcp://localhost:5557
//  Sends batch of tasks to workers via that socket
//
public class taskvent
{
    public static void main(String[] args) throws Exception
    {
        try (ZContext context = new ZContext()) {
            //  Socket to send messages on
            ZMQ.Socket sender = context.createSocket(SocketType.PUSH);
            sender.bind("tcp://*:5557");

            //  Socket to send messages on
            ZMQ.Socket sink = context.createSocket(SocketType.PUSH);
            sink.connect("tcp://localhost:5558");

            System.out.println("Press Enter when the workers are ready: ");
            System.in.read();
            System.out.println("Sending tasks to workers\n");

            //  The first message is "0" and signals start of batch
            sink.send("0", 0);

            //  Initialize random number generator
            Random srandom = new Random(System.currentTimeMillis());

            //  Send 100 tasks
            int task_nbr;
            int total_msec = 0; //  Total expected cost in msecs
            for (task_nbr = 0; task_nbr < 100; task_nbr++) {
                int workload;
                //  Random workload from 1 to 100msecs
                workload = srandom.nextInt(100) + 1;
                total_msec += workload;
                System.out.print(workload + ".");
                String string = String.format("%d", workload);
                sender.send(string, 0);
            }
            System.out.println("Total expected cost: " + total_msec + " msec");
            Thread.sleep(1000); //  Give 0MQ time to deliver
        }
    }
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Java/taskvent.java)

taskvent: Parallel task ventilator in Julia

```julia
#!/usr/bin/env julia

#
# Task ventilator
# Binds PUSH socket to tcp://localhost:5557
# Sends batch of tasks to workers via that socket
#

using ZMQ
using Random: seed!

context = Context()
sender = Socket(context, PUSH)
bind(sender, "tcp://*:5557")

# Socket with direct access to the sink: used to synchronize start of batch
sink = Socket(context, PUSH)
connect(sink, "tcp://localhost:5558")

println("Press Enter when the workers are ready: ")
_ = readline(stdin)
println("Sending tasks to workers...")

# The first message is "0" and signals start of batch
send(sink, 0x30)

# Initialize random number generator
seed!(1)

# Send 100 tasks
total_msec = 0
for task_nbr in 1:100
    global total_msec
    # Random workload from 1 to 100 msecs
    workload = rand(1:100)
    total_msec += workload
    send(sender, "$workload")
end

println("Total expected cost: $total_msec msec")

# Give 0MQ time to deliver
sleep(1)

# Making a clean exit.
close(sender)
close(sink)
close(context)
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Julia/taskvent.jl)

taskvent: Parallel task ventilator in Lua

```lua
--
--  Task ventilator
--  Binds PUSH socket to tcp://localhost:5557
--  Sends batch of tasks to workers via that socket
--
--  Author: Robert G. Jakabosky <bobby@sharedrealm.com>
--
require"zmq"
require"zhelpers"

local context = zmq.init(1)

--  Socket to send messages on
local sender = context:socket(zmq.PUSH)
sender:bind("tcp://*:5557")

printf ("Press Enter when the workers are ready: ")
io.read('*l')
printf ("Sending tasks to workers...\n")

--  The first message is "0" and signals start of batch
sender:send("0")

--  Initialize random number generator
math.randomseed(os.time())

--  Send 100 tasks
local task_nbr
local total_msec = 0     --  Total expected cost in msecs
for task_nbr=0,99 do
    local workload
    --  Random workload from 1 to 100msecs
    workload = randof (100) + 1
    total_msec = total_msec + workload
    local msg = string.format("%d", workload)
    sender:send(msg)
end
printf ("Total expected cost: %d msec\n", total_msec)
s_sleep (1000)              --  Give 0MQ time to deliver

sender:close()
context:term()
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Lua/taskvent.lua)

taskvent: Parallel task ventilator in Node.js

```node.js
// Task ventilator in node.js
// Binds PUSH socket to tcp://localhost:5557
// Sends batch of tasks to workers via that socket.

var zmq = require('zeromq');
process.stdin.resume();
process.stdin.setRawMode(true);

// Socket to send messages on
var sender = zmq.socket('push');
sender.bindSync("tcp://*:5557");

var sink = zmq.socket('push');
sink.connect('tcp://localhost:5558');

var i          = 0
  , total_msec = 0;

function work() {
  console.log("Sending tasks to workers...");

  // The first message is "0" and signals start of batch
  sink.send("0");

  // send 100 tasks
  while (i < 100) {
    var workload = Math.abs(Math.round(Math.random() * 100)) + 1;
    total_msec += workload;
    process.stdout.write(workload.toString() + ".");
    sender.send(workload.toString());
    i++;
  }
  console.log("Total expected cost:", total_msec, "msec");
  sink.close();
  sender.close();
  process.exit();
};

console.log("Press enter when the workers are ready...");
process.stdin.on("data", function() {
  if (i === 0) {
    work();
  }
  process.stdin.pause();
});
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Node.js/taskvent.js)

taskvent: Parallel task ventilator in Objective-C

```objective-c
/* Task ventilator - sends task batch to workers via PUSH socket. */
#import <Foundation/Foundation.h>
#import "ZMQObjC.h"
#import "ZMQHelper.h"

int
main(void)
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	ZMQContext *ctx = [[[ZMQContext alloc] initWithIOThreads:1U] autorelease];
	ZMQSocket *sender = [ctx socketWithType:ZMQ_PUSH];
	[sender bindToEndpoint:@"tcp://*:5557"];

	NSLog(@"Press Enter when the workers are ready: ");
	(void)getchar();
	NSLog(@"Sending tasks to workers...");

	/* Signal batch start with message of "0". */
	NSData *signalData = [@"0" dataUsingEncoding:NSUTF8StringEncoding];
	[sender sendData:signalData withFlags:0];

	/* Initialize random number generator. */
	(void)srandom((unsigned)time(NULL));

	/* Send kTaskCount tasks. */
	unsigned long totalMsec = 0UL;
	static const int kTaskCount = 100;
	for (int task = 0; task < kTaskCount; ++task) {
		/* Random workload from 1 to 100 msec. */
		int workload = within(100) + 1;
		totalMsec += workload;
		NSString *text = [NSString stringWithFormat:@"%d", workload];
		NSData *textData = [text dataUsingEncoding:NSUTF8StringEncoding];
		[sender sendData:textData withFlags:0];
	}
	NSLog(@"Total expected cost: %lu ms", totalMsec);

	/* Let IOThreads finish sending. */
	sleep(1);

	[sender close];
	[pool drain];
	return EXIT_SUCCESS;
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Objective-C/taskvent.m)

taskvent: Parallel task ventilator in ooc

The example **taskvent** is missing in **ooc**:
[Contribute Translation](https://zguide.zeromq.org/translate)

taskvent: Parallel task ventilator in Perl

```perl
# Task ventilator
# Binds PUSH socket to tcp://localhost:5557
# Sends batch of tasks to workers via that socket

use strict;
use warnings;
use v5.10;

use ZMQ::FFI;
use ZMQ::FFI::Constants qw(ZMQ_PUSH);

my $ctx = ZMQ::FFI->new();

# Socket to send messages on
my $sender = $ctx->socket(ZMQ_PUSH);
$sender->bind('tcp://*:5557');

# Socket to send start of batch message on
my $sink = $ctx->socket(ZMQ_PUSH);
$sink->connect('tcp://localhost:5558');

say "Press Enter when the workers are ready: ";
<STDIN>;
say "Sending tasks to workers...";

# The first message is "0" and signals start of batch
$sink->send('0');

# Send 100 tasks
my $total_msec = 0;
my $workload;
for (1..100) {
    $workload    = int(rand(100) + 1);
    $total_msec += $workload;

    $sender->send($workload);
}

say "Total expected cost: $total_msec msec";
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Perl/taskvent.pl)

taskvent: Parallel task ventilator in PHP

```php
<?php
/*
 *  Task ventilator
 *  Binds PUSH socket to tcp://localhost:5557
 *  Sends batch of tasks to workers via that socket
 * @author Ian Barber <ian(dot)barber(at)gmail(dot)com>
 */

$context = new ZMQContext();

//  Socket to send messages on
$sender = new ZMQSocket($context, ZMQ::SOCKET_PUSH);
$sender->bind("tcp://*:5557");

echo "Press Enter when the workers are ready: ";
$fp = fopen('php://stdin', 'r');
$line = fgets($fp, 512);
fclose($fp);
echo "Sending tasks to workers...", PHP_EOL;

//  The first message is "0" and signals start of batch
$sender->send(0);

//  Send 100 tasks
$total_msec = 0;     //  Total expected cost in msecs
for ($task_nbr = 0; $task_nbr < 100; $task_nbr++) {
    //  Random workload from 1 to 100msecs
    $workload = mt_rand(1, 100);
    $total_msec += $workload;
    $sender->send($workload);

}

printf ("Total expected cost: %d msec\n", $total_msec);
sleep (1);              //  Give 0MQ time to deliver
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/PHP/taskvent.php)

taskvent: Parallel task ventilator in Python

```python
# Task ventilator
# Binds PUSH socket to tcp://localhost:5557
# Sends batch of tasks to workers via that socket
#
# Author: Lev Givon <lev(at)columbia(dot)edu>

import zmq
import random
import time

context = zmq.Context()

# Socket to send messages on
sender = context.socket(zmq.PUSH)
sender.bind("tcp://*:5557")

# Socket with direct access to the sink: used to synchronize start of batch
sink = context.socket(zmq.PUSH)
sink.connect("tcp://localhost:5558")

print("Press Enter when the workers are ready: ")
_ = input()
print("Sending tasks to workers...")

# The first message is "0" and signals start of batch
sink.send(b'0')

# Initialize random number generator
random.seed()

# Send 100 tasks
total_msec = 0
for task_nbr in range(100):

    # Random workload from 1 to 100 msecs
    workload = random.randint(1, 100)
    total_msec += workload

    sender.send_string(f"{workload}")

print(f"Total expected cost: {total_msec} msec")

# Give 0MQ time to deliver
time.sleep(1)
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Python/taskvent.py)

taskvent: Parallel task ventilator in Q

The example **taskvent** is missing in **Q**:
[Contribute Translation](https://zguide.zeromq.org/translate)

taskvent: Parallel task ventilator in Racket

The example **taskvent** is missing in **Racket**:
[Contribute Translation](https://zguide.zeromq.org/translate)

taskvent: Parallel task ventilator in Ruby

The example **taskvent** is missing in **Ruby**:
[Contribute Translation](https://zguide.zeromq.org/translate)

taskvent: Parallel task ventilator in Rust

The example **taskvent** is missing in **Rust**:
[Contribute Translation](https://zguide.zeromq.org/translate)

taskvent: Parallel task ventilator in Scala

The example **taskvent** is missing in **Scala**:
[Contribute Translation](https://zguide.zeromq.org/translate)

taskvent: Parallel task ventilator in Tcl

The example **taskvent** is missing in **Tcl**:
[Contribute Translation](https://zguide.zeromq.org/translate)

taskvent: Parallel task ventilator in OCaml

The example **taskvent** is missing in **OCaml**:
[Contribute Translation](https://zguide.zeromq.org/translate)

C \|

C++ \|

C# \|

CL \|

Delphi \|

Erlang \|

Elixir \|

F# \|

Felix \|

Go \|

Haskell \|

Haxe \|

Java \|

Julia \|

Lua \|

Node.js \|

Objective-C \|

Perl \|

PHP \|

Python \|

[Ada \|\\
\\
Basic \|\\
\\
ooc \|\\
\\
Q \|\\
\\
Racket \|\\
\\
Ruby \|\\
\\
Rust \|\\
\\
Scala \|\\
\\
Tcl \|\\
\\
OCaml](https://zguide.zeromq.org/translate)

Here is the worker application. It receives a message, sleeps for that number of seconds, and then signals that it’s finished:

taskwork: Parallel task worker in Ada

The example **taskwork** is missing in **Ada**:
[Contribute Translation](https://zguide.zeromq.org/translate)

taskwork: Parallel task worker in Basic

The example **taskwork** is missing in **Basic**:
[Contribute Translation](https://zguide.zeromq.org/translate)

taskwork: Parallel task worker in C

```c
//  Task worker
//  Connects PULL socket to tcp://localhost:5557
//  Collects workloads from ventilator via that socket
//  Connects PUSH socket to tcp://localhost:5558
//  Sends results to sink via that socket

#include "zhelpers.h"

int main (void)
{
    //  Socket to receive messages on
    void *context = zmq_ctx_new ();
    void *receiver = zmq_socket (context, ZMQ_PULL);
    zmq_connect (receiver, "tcp://localhost:5557");

    //  Socket to send messages to
    void *sender = zmq_socket (context, ZMQ_PUSH);
    zmq_connect (sender, "tcp://localhost:5558");

    //  Process tasks forever
    while (1) {
        char *string = s_recv (receiver);
        printf ("%s.", string);     //  Show progress
        fflush (stdout);
        s_sleep (atoi (string));    //  Do the work
        free (string);
        s_send (sender, "");        //  Send results to sink
    }
    zmq_close (receiver);
    zmq_close (sender);
    zmq_ctx_destroy (context);
    return 0;
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/C/taskwork.c)

taskwork: Parallel task worker in C++

```c++
//
//  Task worker in C++
//  Connects PULL socket to tcp://localhost:5557
//  Collects workloads from ventilator via that socket
//  Connects PUSH socket to tcp://localhost:5558
//  Sends results to sink via that socket
//

#include "zhelpers.hpp"
#include <string>

int main (int argc, char *argv[])
{
    zmq::context_t context(1);

    //  Socket to receive messages on
    zmq::socket_t receiver(context, ZMQ_PULL);
    receiver.connect("tcp://localhost:5557");

    //  Socket to send messages to
    zmq::socket_t sender(context, ZMQ_PUSH);
    sender.connect("tcp://localhost:5558");

    //  Process tasks forever
    while (1) {

        zmq::message_t message;
        int workload;           //  Workload in msecs

        receiver.recv(&message);
        std::string smessage(static_cast<char*>(message.data()), message.size());

        std::istringstream iss(smessage);
        iss >> workload;

        //  Do the work
        s_sleep(workload);

        //  Send results to sink
        message.rebuild();
        sender.send(message);

        //  Simple progress indicator for the viewer
        std::cout << "." << std::flush;
    }
    return 0;
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/C++/taskwork.cpp)

taskwork: Parallel task worker in C#

```c#
﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;

using ZeroMQ;

namespace Examples
{
	static partial class Program
	{
		public static void TaskWork(string[] args)
		{
			//
			// Task worker
			// Connects PULL socket to tcp://127.0.0.1:5557
			// Collects workloads from ventilator via that socket
			// Connects PUSH socket to tcp://127.0.0.1:5558
			// Sends results to sink via that socket
			//
			// Author: metadings
			//

			// Socket to receive messages on and
			// Socket to send messages to
			using (var context = new ZContext())
			using (var receiver = new ZSocket(context, ZSocketType.PULL))
			using (var sink = new ZSocket(context, ZSocketType.PUSH))
			{
				receiver.Connect("tcp://127.0.0.1:5557");
				sink.Connect("tcp://127.0.0.1:5558");

				// Process tasks forever
				while (true)
				{
					var replyBytes = new byte[4];
					receiver.ReceiveBytes(replyBytes, 0, replyBytes.Length);
					int workload = BitConverter.ToInt32(replyBytes, 0);
					Console.WriteLine("{0}.", workload);	// Show progress

					Thread.Sleep(workload);	// Do the work

					sink.Send(new byte[0], 0, 0);	// Send results to sink
				}
			}
		}
	}
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/CSharp/taskwork.cs)

taskwork: Parallel task worker in CL

```cl
;;; -*- Mode:Lisp; Syntax:ANSI-Common-Lisp; -*-
;;;
;;;  Task worker in Common Lisp
;;;  Connects PULL socket to tcp://localhost:5557
;;;  Collects workloads from ventilator via that socket
;;;  Connects PUSH socket to tcp://localhost:5558
;;;  Sends results to sink via that socket
;;;
;;; Kamil Shakirov <kamils80@gmail.com>
;;;

(defpackage #:zguide.taskwork
  (:nicknames #:taskwork)
  (:use #:cl #:zhelpers)
  (:export #:main))

(in-package :zguide.taskwork)

(defun main ()
  (zmq:with-context (context 1)
    ;; Socket to receive messages on
    (zmq:with-socket (receiver context zmq:pull)
      (zmq:connect receiver "tcp://localhost:5557")

      ;; Socket to send messages to
      (zmq:with-socket (sender context zmq:push)
        (zmq:connect sender "tcp://localhost:5558")

        ;; Process tasks forever
        (loop
          (let ((pull-msg (make-instance 'zmq:msg)))
            (zmq:recv receiver pull-msg)

            (let* ((string (zmq:msg-data-as-string pull-msg))
                   (delay (* (parse-integer string) 1000)))
              ;; Simple progress indicator for the viewer
              (message "~A." string)

              ;; Do the work
              (isys:usleep delay)

              ;; Send results to sink
              (let ((push-msg (make-instance 'zmq:msg :data "")))
                (zmq:send sender push-msg))))))))

  (cleanup))
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/CL/taskwork.lisp)

taskwork: Parallel task worker in Delphi

```delphi
program taskwork;
//
//  Task worker
//  Connects PULL socket to tcp://localhost:5557
//  Collects workloads from ventilator via that socket
//  Connects PUSH socket to tcp://localhost:5558
//  Sends results to sink via that socket
//  @author Varga Balazs <bb.varga@gmail.com>
//
{$APPTYPE CONSOLE}

uses
    SysUtils
  , zmqapi
  ;

var
  context: TZMQContext;
  receiver,
  sender: TZMQSocket;
  s: Utf8String;
begin
  context := TZMQContext.Create;

  //  Socket to receive messages on
  receiver := Context.Socket( stPull );
  receiver.connect( 'tcp://localhost:5557' );

  //  Socket to send messages to
  sender := Context.Socket( stPush );
  sender.connect( 'tcp://localhost:5558' );

  //  Process tasks forever
  while True do
  begin
    receiver.recv( s );
    //  Simple progress indicator for the viewer
    Writeln( s );

    //  Do the work
    sleep( StrToInt( s ) );

    //  Send results to sink
    sender.send('');
  end;
  receiver.Free;
  sender.Free;
  context.Free;
end.
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Delphi/taskwork.dpr)

taskwork: Parallel task worker in Erlang

```erlang
#! /usr/bin/env escript
%%
%% Task worker
%% Connects PULL socket to tcp://localhost:5557
%% Collects workloads from ventillator via that socket
%% Connects PUSH socket to tcp://localhost:5558
%% Sends results to sink via that socket
%%

main(_) ->
    application:start(chumak),

    {ok, Receiver} = chumak:socket(pull),

    case chumak:connect(Receiver, tcp, "localhost", 5557) of
        {ok, _ConnectPid} ->
            io:format("Connection OK with Pid: ~p\n", [Receiver]);
        {error, Reason} ->
            io:format("Connection failed for this reason: ~p\n", [Reason])
    end,

    {ok, Sender} = chumak:socket(push),
    case chumak:connect(Sender, tcp, "localhost", 5558) of
        {ok, _ConnectPid1} ->
            io:format("Connection OK with Pid: ~p\n", [Sender])
    end,

    loop(Receiver, Sender).

loop(Receiver, Sender) ->
    {ok, Work} = chumak:recv(Receiver),

    io:format(" . "),

    timer:sleep(list_to_integer(binary_to_list(Work))),

    ok = chumak:send(Sender, <<" ">>),
    loop(Receiver, Sender).
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Erlang/taskwork.es)

taskwork: Parallel task worker in Elixir

```elixir
defmodule Taskwork do
  @moduledoc """
  Generated by erl2ex (http://github.com/dazuma/erl2ex)
  From Erlang source: (Unknown source file)
  At: 2019-12-20 13:57:37

  """

  def main() do
    {:ok, context} = :erlzmq.context()
    {:ok, receiver} = :erlzmq.socket(context, :pull)
    :ok = :erlzmq.connect(receiver, 'tcp://localhost:5557')
    {:ok, sender} = :erlzmq.socket(context, :push)
    :ok = :erlzmq.connect(sender, 'tcp://localhost:5558')
    loop(receiver, sender)
    :ok = :erlzmq.close(receiver)
    :ok = :erlzmq.close(sender)
    :ok = :erlzmq.term(context)
  end

  def loop(receiver, sender) do
    {:ok, work} = :erlzmq.recv(receiver)
    :io.format('.')
    :timer.sleep(:erlang.list_to_integer(:erlang.binary_to_list(work)))
    :ok = :erlzmq.send(sender, "")
    loop(receiver, sender)
  end

end

Taskwork.main
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Elixir/taskwork.exs)

taskwork: Parallel task worker in F#

```f#
(*
Task worker
Connects PULL socket to tcp://localhost:5557
Collects workloads from ventilator via that socket
Connects PUSH socket to tcp://localhost:5558
Sends results to sink via that socket
*)
#r @"bin/fszmq.dll"
open fszmq

#load "zhelpers.fs"

let main () =
  use context = new Context(1)

  // Socket to receive messages on
  use receiver = context |> Context.pull
  Socket.connect receiver "tcp://localhost:5557"

  // Socket to send messages to
  use sender = context |> Context.push
  Socket.connect sender "tcp://localhost:5558"

  // Process tasks forever
  while true do
    let msg = s_recv receiver
    // Simple progress indicator for the viewer
    fflush()
    printf "%s." msg

    // Do the work
    sleep (int msg)

    // Send results to sink
    s_send sender ""

  EXIT_SUCCESS

main ()
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/FSharp/taskwork.fsx)

taskwork: Parallel task worker in Felix

```felix
//
//  Task worker
//  Connects PULL socket to tcp://localhost:5557
//  Collects workloads from ventilator via that socket
//  Connects PUSH socket to tcp://localhost:5558
//  Sends results to sink via that socket

open ZMQ;

var context = zmq_init (1);

//  Socket to receive messages on
var receiver = context.mk_socket ZMQ_PULL;
receiver.connect "tcp://localhost:5557";

//  Socket to send messages to
var sender = context.mk_socket ZMQ_PUSH;
sender.connect "tcp://localhost:5558";

//  Process tasks forever
while true do
  var s = receiver.recv_string;
  //  Simple progress indicator for the viewer
  println s; fflush stdout;

  //  Do the work
  Faio::sleep (sys_clock, atof s/1000.0);

  //  Send results to sink
  sender.send_string "";
done
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Felix/taskwork.flx)

taskwork: Parallel task worker in Go

```go
//
// Task Wroker
// Connects PULL socket to tcp://localhost:5557
// Collects workloads from ventilator via that socket
// Connects PUSH socket to tcp://localhost:5558
// Sends results to sink via that socket
//
package main

import (
	"fmt"
	zmq "github.com/alecthomas/gozmq"
	"strconv"
	"time"
)

func main() {
	context, _ := zmq.NewContext()
	defer context.Close()

	//  Socket to receive messages on
	receiver, _ := context.NewSocket(zmq.PULL)
	defer receiver.Close()
	receiver.Connect("tcp://localhost:5557")

	//  Socket to send messages to task sink
	sender, _ := context.NewSocket(zmq.PUSH)
	defer sender.Close()
	sender.Connect("tcp://localhost:5558")

	//  Process tasks forever
	for {
		msgbytes, _ := receiver.Recv(0)
		fmt.Printf("%s.\n", string(msgbytes))

		//  Do the work
		msec, _ := strconv.ParseInt(string(msgbytes), 10, 64)
		time.Sleep(time.Duration(msec) * 1e6)

		//  Send results to sink
		sender.Send([]byte(""), 0)

	}
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Go/taskwork.go)

taskwork: Parallel task worker in Haskell

```haskell
{-# LANGUAGE OverloadedStrings #-}

--  Task worker
--  Connects PULL socket to tcp://localhost:5557
--  Collects workloads from ventilator via that socket
--  Connects PUSH socket to tcp://localhost:5558
--  Sends results to sink via that socket

module Main where

import           Control.Concurrent
import           Control.Monad
import           Data.Monoid
import qualified Data.ByteString.Char8 as BS
import           System.IO
import           System.ZMQ4.Monadic

main :: IO ()
main = runZMQ $ do
    -- Socket to receive messages on
    receiver <- socket Pull
    connect receiver "tcp://localhost:5557"

    -- Socket to send messages to
    sender <- socket Push
    connect sender "tcp://localhost:5558"

    -- Process tasks forever
    forever $ do
        string <- receive receiver
        liftIO $ do
            BS.putStr (string <> ".")
            hFlush stdout
            threadDelay $ read (BS.unpack string) * 1000
        send sender [] ""
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Haskell/taskwork.hs)

taskwork: Parallel task worker in Haxe

```haxe
package ;

import haxe.io.Bytes;
import neko.Lib;
import neko.Sys;
import org.zeromq.ZMQ;
import org.zeromq.ZMQContext;
import org.zeromq.ZMQSocket;

/**
 * Task worker in Haxe
 * Connects PULL socket to tcp://localhost:5557
 * Collects workloads from ventilator via that socket
 * Connects PUSH socket to tcp://localhost:5558
 * Sends results to sink via that socket
 *
 * See: http://zguide.zeromq.org/page:all#Divide-and-Conquer
 *
 * Based on code from: http://zguide.zeromq.org/java:taskwork
 *
 * Use with TaskVent.hx and TaskSink.hx
 */
class TaskWork
{

	public static function main() {
		var context:ZMQContext = ZMQContext.instance();

		Lib.println("** TaskWork (see: http://zguide.zeromq.org/page:all#Divide-and-Conquer)");

		// Socket to receive messages on
		var receiver:ZMQSocket = context.socket(ZMQ_PULL);
		receiver.connect("tcp://127.0.0.1:5557");

		// Socket to send messages to
		var sender:ZMQSocket = context.socket(ZMQ_PUSH);
		sender.connect("tcp://127.0.0.1:5558");

		// Process tasks forever
		while (true) {
			var msgString = StringTools.trim(receiver.recvMsg().toString());
			var sec:Float = Std.parseFloat(msgString) / 1000.0;
			Lib.print(msgString + ".");

			// Do the work
			Sys.sleep(sec);

			// Send results to sink
			sender.sendMsg(Bytes.ofString(""));
		}


	}
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Haxe/taskwork.hx)

taskwork: Parallel task worker in Java

```java
package guide;

import org.zeromq.SocketType;
import org.zeromq.ZMQ;
import org.zeromq.ZContext;

//
//  Task worker in Java
//  Connects PULL socket to tcp://localhost:5557
//  Collects workloads from ventilator via that socket
//  Connects PUSH socket to tcp://localhost:5558
//  Sends results to sink via that socket
//
public class taskwork
{
    public static void main(String[] args) throws Exception
    {
        try (ZContext context = new ZContext()) {
            //  Socket to receive messages on
            ZMQ.Socket receiver = context.createSocket(SocketType.PULL);
            receiver.connect("tcp://localhost:5557");

            //  Socket to send messages to
            ZMQ.Socket sender = context.createSocket(SocketType.PUSH);
            sender.connect("tcp://localhost:5558");

            //  Process tasks forever
            while (!Thread.currentThread().isInterrupted()) {
                String string = new String(receiver.recv(0), ZMQ.CHARSET).trim();
                long msec = Long.parseLong(string);
                //  Simple progress indicator for the viewer
                System.out.flush();
                System.out.print(string + '.');

                //  Do the work
                Thread.sleep(msec);

                //  Send results to sink
                sender.send(ZMQ.MESSAGE_SEPARATOR, 0);
            }
        }
    }
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Java/taskwork.java)

taskwork: Parallel task worker in Julia

```julia
#!/usr/bin/env julia

#
# Task worker
# Connects PULL socket to tcp://localhost:5557
# Collects workloads from ventilator via that socket
# Connects PUSH socket to tcp://localhost:5558
# Sends results to sink via that socket
#

using ZMQ

context = Context()

# Socket to receive messages on
receiver = Socket(context, PULL)
connect(receiver, "tcp://localhost:5557")

# Socket to send messages to
sender = Socket(context, PUSH)
connect(sender, "tcp://localhost:5558")

# Process tasks forever
while true
    s = recv(receiver, String)

    # Simple progress indicator for the viewer
    write(stdout, ".")
    flush(stdout)

    # Do the work
    sleep(parse(Int, s) * 0.001)

    # Send results to sink
    send(sender, 0x00)
end

close(sender)
close(receiver)
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Julia/taskwork.jl)

taskwork: Parallel task worker in Lua

```lua
--
--  Task worker
--  Connects PULL socket to tcp://localhost:5557
--  Collects workloads from ventilator via that socket
--  Connects PUSH socket to tcp://localhost:5558
--  Sends results to sink via that socket
--
--  Author: Robert G. Jakabosky <bobby@sharedrealm.com>
--
require"zmq"
require"zhelpers"

local context = zmq.init(1)

--  Socket to receive messages on
local receiver = context:socket(zmq.PULL)
receiver:connect("tcp://localhost:5557")

--  Socket to send messages to
local sender = context:socket(zmq.PUSH)
sender:connect("tcp://localhost:5558")

--  Process tasks forever
while true do
    local msg = receiver:recv()
    --  Simple progress indicator for the viewer
    io.stdout:flush()
    printf("%s.", msg)

    --  Do the work
    s_sleep(tonumber(msg))

    --  Send results to sink
    sender:send("")
end
receiver:close()
sender:close()
context:term()
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Lua/taskwork.lua)

taskwork: Parallel task worker in Node.js

```node.js
// Task worker in node.js
// Connects PULL socket to tcp://localhost:5557
// Collects workloads from ventilator via that socket
// Connects PUSH socket to tcp://localhost:5558
// Sends results to sink via that socket

var zmq      = require('zeromq')
  , receiver = zmq.socket('pull')
  , sender   = zmq.socket('push');

receiver.on('message', function(buf) {
  var msec = parseInt(buf.toString(), 10);

  // simple progress indicator for the viewer
  process.stdout.write(buf.toString() + ".");

  // do the work
  // not a great node sample for zeromq,
  // node receives messages while timers run.
  setTimeout(function() {
    sender.send("");
  }, msec);
});

receiver.connect('tcp://localhost:5557');
sender.connect('tcp://localhost:5558');

process.on('SIGINT', function() {
  receiver.close();
  sender.close();
  process.exit();
});
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Node.js/taskwork.js)

taskwork: Parallel task worker in Objective-C

```objective-c
/* taskwork.m: PULLs workload from tcp://localhost:5557
 * PUSHes results to tcp://localhost:5558
 */
#import <Foundation/Foundation.h>
#import "ZMQObjC.h"
#define NSEC_PER_MSEC (1000000)

int
main(void)
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	ZMQContext *ctx = [[[ZMQContext alloc] initWithIOThreads:1U] autorelease];

	/* (jws/2011-02-05)!!!: Do NOT terminate the endpoint with a final slash.
	 * If you connect to @"tcp://localhost:5557/", you will get
	 *    Assertion failed: rc == 0 (zmq_connecter.cpp:46)
	 * instead of a connected socket. Binding works fine, though. */
	ZMQSocket *pull = [ctx socketWithType:ZMQ_PULL];
	[pull connectToEndpoint:@"tcp://localhost:5557"];

	ZMQSocket *push = [ctx socketWithType:ZMQ_PUSH];
	[push connectToEndpoint:@"tcp://localhost:5558"];

	/* Process tasks forever. */
	struct timespec t;
	NSData *emptyData = [NSData data];
	for (;;) {
		NSAutoreleasePool *p = [[NSAutoreleasePool alloc] init];

		NSData *d = [pull receiveDataWithFlags:0];
		NSString *s = [NSString stringWithUTF8String:[d bytes]];
		t.tv_sec = 0;
		t.tv_nsec = [s integerValue] * NSEC_PER_MSEC;
		printf("%d.", [s intValue]);
		fflush(stdout);

		/* Do work, then report finished. */
		(void)nanosleep(&t, NULL);
		[push sendData:emptyData withFlags:0];

		[p drain];
	}

	[ctx closeSockets];
	[pool drain];
	return EXIT_SUCCESS;
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Objective-C/taskwork.m)

taskwork: Parallel task worker in ooc

The example **taskwork** is missing in **ooc**:
[Contribute Translation](https://zguide.zeromq.org/translate)

taskwork: Parallel task worker in Perl

```perl
# Task worker in Perl
# Connects PULL socket to tcp://localhost:5557
# Collects workloads from ventilator via that socket
# Connects PUSH socket to tcp://localhost:5558
# Sends results to sink via that socket

use strict;
use warnings;

$| = 1; # autoflush stdout after each print

use Time::HiRes qw(usleep);

use ZMQ::FFI;
use ZMQ::FFI::Constants qw(ZMQ_PUSH ZMQ_PULL);

my $context = ZMQ::FFI->new();

# Socket to receive messages on
my $receiver = $context->socket(ZMQ_PULL);
$receiver->connect('tcp://localhost:5557');

# Socket to send messages on
my $sender = $context->socket(ZMQ_PUSH);
$sender->connect('tcp://localhost:5558');

# Process tasks forever
my $string;
while (1) {
    $string = $receiver->recv();

    print "$string.";    # Show progress
    usleep $string*1000; # Do the work
    $sender->send("");   # Send results to sink
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Perl/taskwork.pl)

taskwork: Parallel task worker in PHP

```php
<?php
/*
 *  Task worker
 *  Connects PULL socket to tcp://localhost:5557
 *  Collects workloads from ventilator via that socket
 *  Connects PUSH socket to tcp://localhost:5558
 *  Sends results to sink via that socket
 * @author Ian Barber <ian(dot)barber(at)gmail(dot)com>
 */

$context = new ZMQContext();

//  Socket to receive messages on
$receiver = new ZMQSocket($context, ZMQ::SOCKET_PULL);
$receiver->connect("tcp://localhost:5557");

//  Socket to send messages to
$sender = new ZMQSocket($context, ZMQ::SOCKET_PUSH);
$sender->connect("tcp://localhost:5558");

//  Process tasks forever
while (true) {
    $string = $receiver->recv();

    //  Simple progress indicator for the viewer
    echo $string, PHP_EOL;

    //  Do the work
    usleep($string * 1000);

   //  Send results to sink
    $sender->send("");
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/PHP/taskwork.php)

taskwork: Parallel task worker in Python

```python
# Task worker
# Connects PULL socket to tcp://localhost:5557
# Collects workloads from ventilator via that socket
# Connects PUSH socket to tcp://localhost:5558
# Sends results to sink via that socket
#
# Author: Lev Givon <lev(at)columbia(dot)edu>

import sys
import time
import zmq

context = zmq.Context()

# Socket to receive messages on
receiver = context.socket(zmq.PULL)
receiver.connect("tcp://localhost:5557")

# Socket to send messages to
sender = context.socket(zmq.PUSH)
sender.connect("tcp://localhost:5558")

# Process tasks forever
while True:
    s = receiver.recv()

    # Simple progress indicator for the viewer
    sys.stdout.write('.')
    sys.stdout.flush()

    # Do the work
    time.sleep(int(s)*0.001)

    # Send results to sink
    sender.send(b'')
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Python/taskwork.py)

taskwork: Parallel task worker in Q

The example **taskwork** is missing in **Q**:
[Contribute Translation](https://zguide.zeromq.org/translate)

taskwork: Parallel task worker in Racket

The example **taskwork** is missing in **Racket**:
[Contribute Translation](https://zguide.zeromq.org/translate)

taskwork: Parallel task worker in Ruby

The example **taskwork** is missing in **Ruby**:
[Contribute Translation](https://zguide.zeromq.org/translate)

taskwork: Parallel task worker in Rust

The example **taskwork** is missing in **Rust**:
[Contribute Translation](https://zguide.zeromq.org/translate)

taskwork: Parallel task worker in Scala

The example **taskwork** is missing in **Scala**:
[Contribute Translation](https://zguide.zeromq.org/translate)

taskwork: Parallel task worker in Tcl

The example **taskwork** is missing in **Tcl**:
[Contribute Translation](https://zguide.zeromq.org/translate)

taskwork: Parallel task worker in OCaml

The example **taskwork** is missing in **OCaml**:
[Contribute Translation](https://zguide.zeromq.org/translate)

C \|

C++ \|

C# \|

CL \|

Delphi \|

Erlang \|

Elixir \|

F# \|

Felix \|

Go \|

Haskell \|

Haxe \|

Java \|

Julia \|

Lua \|

Node.js \|

Objective-C \|

Perl \|

PHP \|

Python \|

[Ada \|\\
\\
Basic \|\\
\\
ooc \|\\
\\
Q \|\\
\\
Racket \|\\
\\
Ruby \|\\
\\
Rust \|\\
\\
Scala \|\\
\\
Tcl \|\\
\\
OCaml](https://zguide.zeromq.org/translate)

Here is the sink application. It collects the 100 tasks, then calculates how long the overall processing took, so we can confirm that the workers really were running in parallel if there are more than one of them:

tasksink: Parallel task sink in Ada

The example **tasksink** is missing in **Ada**:
[Contribute Translation](https://zguide.zeromq.org/translate)

tasksink: Parallel task sink in Basic

The example **tasksink** is missing in **Basic**:
[Contribute Translation](https://zguide.zeromq.org/translate)

tasksink: Parallel task sink in C

```c
//  Task sink
//  Binds PULL socket to tcp://localhost:5558
//  Collects results from workers via that socket

#include "zhelpers.h"

int main (void)
{
    //  Prepare our context and socket
    void *context = zmq_ctx_new ();
    void *receiver = zmq_socket (context, ZMQ_PULL);
    zmq_bind (receiver, "tcp://*:5558");

    //  Wait for start of batch
    char *string = s_recv (receiver);
    free (string);

    //  Start our clock now
    int64_t start_time = s_clock ();

    //  Process 100 confirmations
    int task_nbr;
    for (task_nbr = 0; task_nbr < 100; task_nbr++) {
        char *string = s_recv (receiver);
        free (string);
        if (task_nbr % 10 == 0)
            printf (":");
        else
            printf (".");
        fflush (stdout);
    }
    //  Calculate and report duration of batch
    printf ("Total elapsed time: %d msec\n",
        (int) (s_clock () - start_time));

    zmq_close (receiver);
    zmq_ctx_destroy (context);
    return 0;
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/C/tasksink.c)

tasksink: Parallel task sink in C++

```c++
//
//  Task sink in C++
//  Binds PULL socket to tcp://localhost:5558
//  Collects results from workers via that socket
//

#include <zmq.hpp>
#include <time.h>
#include <sys/time.h>
#include <iostream>

int main (int argc, char *argv[])
{
    //  Prepare our context and socket
    zmq::context_t context(1);
    zmq::socket_t receiver(context,ZMQ_PULL);
    receiver.bind("tcp://*:5558");

    //  Wait for start of batch
    zmq::message_t message;
    receiver.recv(&message);

    //  Start our clock now
    struct timeval tstart;
    gettimeofday (&tstart, NULL);

    //  Process 100 confirmations
    int task_nbr;
    int total_msec = 0;     //  Total calculated cost in msecs
    for (task_nbr = 0; task_nbr < 100; task_nbr++) {

        receiver.recv(&message);
        if (task_nbr % 10 == 0)
            std::cout << ":" << std::flush;
        else
            std::cout << "." << std::flush;
    }
    //  Calculate and report duration of batch
    struct timeval tend, tdiff;
    gettimeofday (&tend, NULL);

    if (tend.tv_usec < tstart.tv_usec) {
        tdiff.tv_sec = tend.tv_sec - tstart.tv_sec - 1;
        tdiff.tv_usec = 1000000 + tend.tv_usec - tstart.tv_usec;
    }
    else {
        tdiff.tv_sec = tend.tv_sec - tstart.tv_sec;
        tdiff.tv_usec = tend.tv_usec - tstart.tv_usec;
    }
    total_msec = tdiff.tv_sec * 1000 + tdiff.tv_usec / 1000;
    std::cout << "\nTotal elapsed time: " << total_msec << " msec\n" << std::endl;
    return 0;
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/C++/tasksink.cpp)

tasksink: Parallel task sink in C#

```c#
﻿using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading;

using ZeroMQ;

namespace Examples
{
	static partial class Program
	{
		public static void TaskSink(string[] args)
		{
			//
			// Task sink
			// Binds PULL socket to tcp://127.0.0.1:5558
			// Collects results from workers via that socket
			//
			// Author: metadings
			//

			// Prepare our context and socket
			using (var context = new ZContext())
			using (var sink = new ZSocket(context, ZSocketType.PULL))
			{
				sink.Bind("tcp://*:5558");

				// Wait for start of batch
				sink.ReceiveFrame();

				// Start our clock now
				var stopwatch = new Stopwatch();
				stopwatch.Start();

				// Process 100 confirmations
				for (int i = 0; i < 100; ++i)
				{
					sink.ReceiveFrame();

					if ((i / 10) * 10 == i)
						Console.Write(":");
					else
						Console.Write(".");
				}

				// Calculate and report duration of batch
				stopwatch.Stop();
				Console.WriteLine("Total elapsed time: {0} ms", stopwatch.ElapsedMilliseconds);
			}
		}
	}
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/CSharp/tasksink.cs)

tasksink: Parallel task sink in CL

```cl
;;; -*- Mode:Lisp; Syntax:ANSI-Common-Lisp; -*-
;;;
;;;  Task sink in Common Lisp
;;;  Binds PULL socket to tcp://localhost:5558
;;;  Collects results from workers via that socket
;;;
;;; Kamil Shakirov <kamils80@gmail.com>
;;;

(defpackage #:zguide.tasksink
  (:nicknames #:tasksink)
  (:use #:cl #:zhelpers)
  (:export #:main))

(in-package :zguide.tasksink)

(defun main ()
  ;; Prepare our context and socket
  (zmq:with-context (context 1)
    (zmq:with-socket (receiver context zmq:pull)
      (zmq:bind receiver "tcp://*:5558")

      ;; Wait for start of batch
      (let ((msg (make-instance 'zmq:msg)))
        (zmq:recv receiver msg))

      ;; Start our clock now
      (let ((elapsed-time
             (with-stopwatch
               (dotimes (task-nbr 100)
                 (let ((msg (make-instance 'zmq:msg)))
                   (zmq:recv receiver msg)
                   (let ((string (zmq:msg-data-as-string msg)))
                     (declare (ignore string))

                     (if (= 1 (denominator (/ task-nbr 10)))
                         (message ":")
                         (message "."))))))))

        ;; Calculate and report duration of batch
        (message "Total elapsed time: ~F msec~%" (/ elapsed-time 1000.0)))))

  (cleanup))
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/CL/tasksink.lisp)

tasksink: Parallel task sink in Delphi

```delphi
program tasksink;
//
//  Task sink
//  Binds PULL socket to tcp://localhost:5558
//  Collects results from workers via that socket
//  @author Varga Balazs <bb.varga@gmail.com>
//
{$APPTYPE CONSOLE}

uses
    SysUtils
  , Windows
  , zmqapi
  ;

const
  task_count = 100;
var
  context: TZMQContext;
  receiver: TZMQSocket;
  s: Utf8String;

  i: Integer;
  fFrequency,
  fstart,
  fStop : Int64;
begin
  //  Prepare our context and socket
  context := TZMQContext.Create;
  receiver := Context.Socket( stPull );
  receiver.bind( 'tcp://*:5558' );

  //  Wait for start of batch
  receiver.recv( s );

  //  Start our clock now
  QueryPerformanceFrequency( fFrequency );
  QueryPerformanceCounter( fStart );

  //  Process 100 confirmations
  for i := 0 to task_count - 1 do
  begin
    receiver.recv( s );
    if ((i / 10) * 10 = i) then
      Write( ':' )
    else
      Write( '.' );
  end;
  //  Calculate and report duration of batch
  QueryPerformanceCounter( fStop );
  Writeln( Format( 'Total elapsed time: %d msec', [\
    ((MSecsPerSec * (fStop - fStart)) div fFrequency) ]) );

  receiver.Free;
  context.Free;
 end.
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Delphi/tasksink.dpr)

tasksink: Parallel task sink in Erlang

```erlang
#! /usr/bin/env escript
%%
%% Task sink
%% Binds PULL socket to tcp://localhost:5558
%% Collects results from workers via that socket
%%

main(_) ->
    application:start(chumak),

    {ok, Receiver} = chumak:socket(pull),

    case chumak:connect(Receiver, tcp, "localhost", 5557) of
        {ok, _ConnectPid} ->
            io:format("Connection OK with Pid: ~p\n", [Receiver]);
        {error, Reason} ->
            io:format("Connection failed for this reason: ~p\n", [Reason])
    end,

    {ok, Sender} = chumak:socket(push),
    case chumak:connect(Sender, tcp, "localhost", 5558) of
        {ok, _ConnectPid1} ->
            io:format("Connection OK with Pid: ~p\n", [Sender])
    end,

    loop(Receiver, Sender).

loop(Receiver, Sender) ->
    {ok, Work} = chumak:recv(Receiver),

    io:format(" . "),

    timer:sleep(list_to_integer(binary_to_list(Work))),

    ok = chumak:send(Sender, <<" ">>),
    loop(Receiver, Sender).
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Erlang/tasksink.es)

tasksink: Parallel task sink in Elixir

```elixir
defmodule Tasksink do
  @moduledoc """
  Generated by erl2ex (http://github.com/dazuma/erl2ex)
  From Erlang source: (Unknown source file)
  At: 2019-12-20 13:57:36

  """

  def main() do
    {:ok, context} = :erlzmq.context()
    {:ok, receiver} = :erlzmq.socket(context, :pull)
    :ok = :erlzmq.bind(receiver, 'tcp://*:5558')
    {:ok, _} = :erlzmq.recv(receiver)
    start = :erlang.now()
    process_confirmations(receiver, 100)
    :io.format('Total elapsed time: ~b msec~n', [div(:timer.now_diff(:erlang.now(), start), 1000)])
    :ok = :erlzmq.close(receiver)
    :ok = :erlzmq.term(context)
  end

  def process_confirmations(_receiver, 0) do
    :ok
  end

  def process_confirmations(receiver, n) when n > 0 do
    {:ok, _} = :erlzmq.recv(receiver)
    case(n - rem(1, 10)) do
      0 ->
        :io.format(':')
      _ ->
        :io.format('.')
    end
    process_confirmations(receiver, n - 1)
  end

end

Tasksink.main
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Elixir/tasksink.exs)

tasksink: Parallel task sink in F#

```f#
(*
Task sink
Binds PULL socket to tcp://localhost:5558
Collects results from workers via that socket
*)
#r @"bin/fszmq.dll"
open fszmq

#load "zhelpers.fs"

let main () =
  // Prepare our context and socket
  use context  = new Context(1)
  use receiver = context |> Context.pull
  Socket.bind receiver "tcp://*:5558"

  // Wait for start of batch
  s_recv receiver |> ignore

  // Start our clock now
  let watch = s_clock_start()

  // Process 100 confirmations
  for task_nbr in 0 .. 99 do
    s_recv receiver |> ignore
    printf (if (task_nbr / 10) * 10 = task_nbr then ":" else ".")
    fflush()

  // Calculate and report duration of batch
  printfn "Total elapsed time: %d msec" (s_clock_stop watch)

  EXIT_SUCCESS

main ()
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/FSharp/tasksink.fsx)

tasksink: Parallel task sink in Felix

```felix
//
//  Task sink
//  Binds PULL socket to tcp://localhost:5558
//  Collects results from workers via that socket
//
include "std/posix/time";
open ZMQ;

//  Prepare our context and socket
var context = zmq_init 1;
var receiver = context.mk_socket ZMQ_PULL;
receiver.bind "tcp://*:5558";

//  Wait for start of batch
C_hack::ignore receiver.recv_string;

//  Start our clock now
var start_time = #Time::time;

//  Process 100 confirmations
for var task_nbr in 0 upto 99 do
  C_hack::ignore receiver.recv_string;
  if (task_nbr / 10) * 10 == task_nbr do
    print ":";
  else
    print ".";
  fflush (stdout);
  done
done
//  Calculate and report duration of batch
var now = #Time::time;
println$ f"Total elapsed time: %d ms"
  ((now  - start_time)*1000.0).int
;

receiver.close;
context.term;
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Felix/tasksink.flx)

tasksink: Parallel task sink in Go

```go
//
// Task sink
// Binds PULL socket to tcp://localhost:5558
// Collects results from workers via that socket
//
package main

import (
	"fmt"
	zmq "github.com/alecthomas/gozmq"
	"time"
)

func main() {
	context, _ := zmq.NewContext()
	defer context.Close()

	//  Socket to receive messages on
	receiver, _ := context.NewSocket(zmq.PULL)
	defer receiver.Close()
	receiver.Bind("tcp://*:5558")

	//  Wait for start of batch
	msgbytes, _ := receiver.Recv(0)
	fmt.Println("Received Start Msg ", string(msgbytes))

	//  Start our clock now
	start_time := time.Now().UnixNano()

	//  Process 100 confirmations
	for i := 0; i < 100; i++ {
		msgbytes, _ = receiver.Recv(0)
		fmt.Print(".")
	}

	//  Calculate and report duration of batch
	te := time.Now().UnixNano()
	fmt.Printf("Total elapsed time: %d msec\n", (te-start_time)/1e6)

}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Go/tasksink.go)

tasksink: Parallel task sink in Haskell

```haskell
--  Task sink
--  Binds PULL socket to tcp://localhost:5558
--  Collects results from workers via that socket

module Main where

import Control.Monad
import Data.Time.Clock
import System.IO
import System.ZMQ4.Monadic

main :: IO ()
main = runZMQ $ do
    -- Prepare our socket
    receiver <- socket Pull
    bind receiver "tcp://*:5558"

    -- Wait for start of batch
    _ <- receive receiver

    -- Start our clock now
    start_time <- liftIO getCurrentTime

    -- Process 100 confirmations
    liftIO $ hSetBuffering stdout NoBuffering
    forM_ [1..100] $ \i -> do
        _ <- receive receiver
        if i `mod` 10 == 0
            then liftIO $ putStr ":"
            else liftIO $ putStr "."

    -- Calculate and report duration of batch
    end_time <- liftIO getCurrentTime
    liftIO . putStrLn $ "Total elapsed time: " ++ show (diffUTCTime end_time start_time * 1000) ++ " msec"
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Haskell/tasksink.hs)

tasksink: Parallel task sink in Haxe

```haxe
package ;

import haxe.io.Bytes;
import neko.Lib;
import neko.Sys;
import org.zeromq.ZMQ;
import org.zeromq.ZMQContext;
import org.zeromq.ZMQSocket;

/**
 * Task sink in Haxe
 * Binds PULL request socket to tcp://localhost:5558
 * Collects results from workers via this socket
 *
 * See: http://zguide.zeromq.org/page:all#Divide-and-Conquer
 *
 * Based on http://zguide.zeromq.org/java:tasksink
 *
 * Use with TaskVent.hx and TaskWork.hx
 */
class TaskSink
{

	public static function main() {
		var context:ZMQContext = ZMQContext.instance();

		Lib.println("** TaskSink (see: http://zguide.zeromq.org/page:all#Divide-and-Conquer)");

		// Socket to receive messages on
		var receiver:ZMQSocket = context.socket(ZMQ_PULL);
		receiver.bind("tcp://127.0.0.1:5558");

		// Wait for start of batch
		var msgString = StringTools.trim(receiver.recvMsg().toString());

		// Start our clock now
		var tStart = Sys.time();

		// Process 100 messages
		var task_nbr:Int;
		for (task_nbr in 0 ... 100) {
			msgString = StringTools.trim(receiver.recvMsg().toString());
			if (task_nbr % 10 == 0) {
				Lib.println(":");		// Print a ":" every 10 messages
			} else {
				Lib.print(".");
			}
		}
		// Calculate and report duation of batch
		var tEnd = Sys.time();
		Lib.println("Total elapsed time: " + Math.ceil((tEnd - tStart) * 1000) + " msec");

		receiver.close();
		context.term();
	}
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Haxe/tasksink.hx)

tasksink: Parallel task sink in Java

```java
package guide;

import org.zeromq.SocketType;
import org.zeromq.ZMQ;
import org.zeromq.ZContext;

//
//  Task sink in Java
//  Binds PULL socket to tcp://localhost:5558
//  Collects results from workers via that socket
//
public class tasksink
{
    public static void main(String[] args) throws Exception
    {
        //  Prepare our context and socket
        try (ZContext context = new ZContext()) {
            ZMQ.Socket receiver = context.createSocket(SocketType.PULL);
            receiver.bind("tcp://*:5558");

            //  Wait for start of batch
            String string = new String(receiver.recv(0), ZMQ.CHARSET);

            //  Start our clock now
            long tstart = System.currentTimeMillis();

            //  Process 100 confirmations
            int task_nbr;
            int total_msec = 0; //  Total calculated cost in msecs
            for (task_nbr = 0; task_nbr < 100; task_nbr++) {
                string = new String(receiver.recv(0), ZMQ.CHARSET).trim();
                if ((task_nbr / 10) * 10 == task_nbr) {
                    System.out.print(":");
                }
                else {
                    System.out.print(".");
                }
            }

            //  Calculate and report duration of batch
            long tend = System.currentTimeMillis();

            System.out.println(
                "\nTotal elapsed time: " + (tend - tstart) + " msec"
            );
        }
    }
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Java/tasksink.java)

tasksink: Parallel task sink in Julia

```julia
#!/usr/bin/env julia

#
# Task sink
# Binds PULL socket to tcp://localhost:5558
# Collects results from workers via that socket
#

using ZMQ
using Dates

context = Context()

# Socket to receive messages on
receiver = Socket(context, PULL)
bind(receiver, "tcp://*:5558")

# Wait for start of batch
s = recv(receiver)

# Start our tic toc clock
tstart = now()

# Process 100 confirmations
for task_nbr in 1:100
    s = recv(receiver)
    if task_nbr % 10 == 0
        write(stdout, ":")
    else
        write(stdout, ".")
    end
    flush(stdout)
end

# Calculate and report duration of batch
tend = now()
elapsed = tend - tstart
println("\nTotal elapsed time: $(elapsed * 1000) msec")

# Making a clean exit.
close(receiver)
close(context)
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Julia/tasksink.jl)

tasksink: Parallel task sink in Lua

```lua
--
--  Task sink
--  Binds PULL socket to tcp://localhost:5558
--  Collects results from workers via that socket
--
--  Author: Robert G. Jakabosky <bobby@sharedrealm.com>
--
require"zmq"
require"zhelpers"
local fmod = math.fmod

--  Prepare our context and socket
local context = zmq.init(1)
local receiver = context:socket(zmq.PULL)
receiver:bind("tcp://*:5558")

--  Wait for start of batch
local msg = receiver:recv()

--  Start our clock now
local start_time = s_clock ()

--  Process 100 confirmations
local task_nbr
for task_nbr=0,99 do
    local msg = receiver:recv()

    if (fmod(task_nbr, 10) == 0) then
        printf (":")
    else
        printf (".")
    end
    io.stdout:flush()
end
--  Calculate and report duration of batch
printf("Total elapsed time: %d msec\n", (s_clock () - start_time))

receiver:close()
context:term()
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Lua/tasksink.lua)

tasksink: Parallel task sink in Node.js

```node.js
// Task sink in node.js
// Binds PULL socket to tcp://localhost:5558
// Collects results from workers via that socket.

var zmq  = require('zeromq')
  , receiver = zmq.socket('pull');

var started = false
  , i = 0
  , label = "Total elapsed time";

receiver.on('message', function() {
  // wait for start of batch
  if (!started) {
    console.time(label);
    started = true;

  // process 100 confirmations
  } else {
    i += 1;
    process.stdout.write(i % 10 === 0 ? ':' : '.');
    if (i === 100) {
      console.timeEnd(label);
      receiver.close();
      process.exit();
    }
  }
});

receiver.bindSync("tcp://*:5558");
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Node.js/tasksink.js)

tasksink: Parallel task sink in Objective-C

```objective-c
/* tasksink.m: PULLs workers' results from tcp://localhost:5558/. */
/* You can wire up the vent, workers, and sink like so:
 *    $ ./tasksink &
 *    $ ./taskwork &  # Repeat this as many times as you want workers.
 *    $ ./taskvent &
 */
#import <Foundation/Foundation.h>
#import "ZMQObjC.h"

#import <sys/time.h>
#define NSEC_PER_MSEC (1000000)
#define MSEC_PER_SEC  (1000)

int
main(void)
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

	/* Prepare context and socket. */
	ZMQContext *ctx = [[[ZMQContext alloc] initWithIOThreads:1U] autorelease];
	ZMQSocket *pull = [ctx socketWithType:ZMQ_PULL];
	[pull bindToEndpoint:@"tcp://*:5558"];

	/* Wait for batch start. */
	/* Cast result to void because we don't actually care about the value.
	 * The return value has been autoreleased, so no memory is leaked. */
	(void)[pull receiveDataWithFlags:0];

	/* Start clock. */
	struct timeval tstart, tdiff, tend;
	(void)gettimeofday(&tstart, NULL);

	/* Process |kTaskCount| confirmations. */
	static const int kTaskCount = 100;
	for (int task = 0; task < kTaskCount; ++task) {
		NSAutoreleasePool *p = [[NSAutoreleasePool alloc] init];

		(void)[pull receiveDataWithFlags:0];

		BOOL isMultipleOfTen = (0 == (task % 10));
		if (isMultipleOfTen) {
			fputs(":", stdout);
		} else {
			fputs(".", stdout);
		}
		fflush(stdout);

		[p drain];
	}
	fputc('\n', stdout);

	/* Stop clock. */
	(void)gettimeofday(&tend, NULL);

	/* Calculate the difference. */
	tdiff.tv_sec = tend.tv_sec - tstart.tv_sec;
	tdiff.tv_usec = tend.tv_usec - tstart.tv_usec;
	if (tdiff.tv_usec < 0) {
		tdiff.tv_sec -= 1;
		tdiff.tv_usec += NSEC_PER_SEC;
	}

	/* Convert it to milliseconds. */
	unsigned long totalMsec = tdiff.tv_sec * MSEC_PER_SEC
			+ tdiff.tv_usec / NSEC_PER_MSEC;
	NSLog(@"Total elapsed time: %lu ms", totalMsec);

	[ctx closeSockets];
	[pool drain];
	return EXIT_SUCCESS;
}
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Objective-C/tasksink.m)

tasksink: Parallel task sink in ooc

The example **tasksink** is missing in **ooc**:
[Contribute Translation](https://zguide.zeromq.org/translate)

tasksink: Parallel task sink in Perl

```perl
# Task sink in Perl
# Binds PULL socket to tcp://localhost:5558
# Collects results from workers via that socket

use strict;
use warnings;
use v5.10;

use Time::HiRes qw(time);

$| = 1; # autoflush stdout after each print

use ZMQ::FFI;
use ZMQ::FFI::Constants qw(ZMQ_PULL);

# Prepare our context and socket
my $ctx      = ZMQ::FFI->new();
my $receiver = $ctx->socket(ZMQ_PULL);
$receiver->bind('tcp://*:5558');

# Wait for start of batch
my $string = $receiver->recv();

# Start our clock now;
my $start_time = time();

# Process 100 confirmations
for my $task_nbr (0..99) {
    $receiver->recv();

    if ($task_nbr % 10 == 0) {
        print ":";
    }
    else {
        print ".";
    }
}

# Calculate and report duration of batch
printf "Total elapsed time: %d msec\n",
    (time() - $start_time) * 1000;
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Perl/tasksink.pl)

tasksink: Parallel task sink in PHP

```php
<?php
/*
 *  Task sink
 *  Binds PULL socket to tcp://localhost:5558
 *  Collects results from workers via that socket
 * @author Ian Barber <ian(dot)barber(at)gmail(dot)com>
 */

//  Prepare our context and socket
$context = new ZMQContext();
$receiver = new ZMQSocket($context, ZMQ::SOCKET_PULL);
$receiver->bind("tcp://*:5558");

//  Wait for start of batch
$string = $receiver->recv();

//  Start our clock now
$tstart = microtime(true);

//  Process 100 confirmations
$total_msec = 0;     //  Total calculated cost in msecs
for ($task_nbr = 0; $task_nbr < 100; $task_nbr++) {
    $string = $receiver->recv();
    if ($task_nbr % 10 == 0) {
        echo ":";
    } else {
        echo ".";
    }
}

$tend = microtime(true);

$total_msec = ($tend - $tstart) * 1000;
echo PHP_EOL;
printf ("Total elapsed time: %d msec", $total_msec);
echo PHP_EOL;
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/PHP/tasksink.php)

tasksink: Parallel task sink in Python

```python
# Task sink
# Binds PULL socket to tcp://localhost:5558
# Collects results from workers via that socket
#
# Author: Lev Givon <lev(at)columbia(dot)edu>

import sys
import time
import zmq

context = zmq.Context()

# Socket to receive messages on
receiver = context.socket(zmq.PULL)
receiver.bind("tcp://*:5558")

# Wait for start of batch
s = receiver.recv()

# Start our clock now
tstart = time.time()

# Process 100 confirmations
for task_nbr in range(100):
    s = receiver.recv()
    if task_nbr % 10 == 0:
        sys.stdout.write(':')
    else:
        sys.stdout.write('.')
    sys.stdout.flush()

# Calculate and report duration of batch
tend = time.time()
print(f"Total elapsed time: {(tend-tstart)*1000} msec")
```

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this example](https://github.com/booksbyus/zguide/edit/master//examples/Python/tasksink.py)

tasksink: Parallel task sink in Q

The example **tasksink** is missing in **Q**:
[Contribute Translation](https://zguide.zeromq.org/translate)

tasksink: Parallel task sink in Racket

The example **tasksink** is missing in **Racket**:
[Contribute Translation](https://zguide.zeromq.org/translate)

tasksink: Parallel task sink in Ruby

The example **tasksink** is missing in **Ruby**:
[Contribute Translation](https://zguide.zeromq.org/translate)

tasksink: Parallel task sink in Rust

The example **tasksink** is missing in **Rust**:
[Contribute Translation](https://zguide.zeromq.org/translate)

tasksink: Parallel task sink in Scala

The example **tasksink** is missing in **Scala**:
[Contribute Translation](https://zguide.zeromq.org/translate)

tasksink: Parallel task sink in Tcl

The example **tasksink** is missing in **Tcl**:
[Contribute Translation](https://zguide.zeromq.org/translate)

tasksink: Parallel task sink in OCaml

The example **tasksink** is missing in **OCaml**:
[Contribute Translation](https://zguide.zeromq.org/translate)

C \|

C++ \|

C# \|

CL \|

Delphi \|

Erlang \|

Elixir \|

F# \|

Felix \|

Go \|

Haskell \|

Haxe \|

Java \|

Julia \|

Lua \|

Node.js \|

Objective-C \|

Perl \|

PHP \|

Python \|

[Ada \|\\
\\
Basic \|\\
\\
ooc \|\\
\\
Q \|\\
\\
Racket \|\\
\\
Ruby \|\\
\\
Rust \|\\
\\
Scala \|\\
\\
Tcl \|\\
\\
OCaml](https://zguide.zeromq.org/translate)

The average cost of a batch is 5 seconds. When we start 1, 2, or 4 workers we get results like this from the sink:

- 1 worker: total elapsed time: 5034 msecs.
- 2 workers: total elapsed time: 2421 msecs.
- 4 workers: total elapsed time: 1018 msecs.

Let’s look at some aspects of this code in more detail:

- The workers connect upstream to the ventilator, and downstream to the sink. This means you can add workers arbitrarily. If the workers bound to their endpoints, you would need (a) more endpoints and (b) to modify the ventilator and/or the sink each time you added a worker. We say that the ventilator and sink are _stable_ parts of our architecture and the workers are _dynamic_ parts of it.

- We have to synchronize the start of the batch with all workers being up and running. This is a fairly common gotcha in ZeroMQ and there is no easy solution. The `zmq_connect` method takes a certain time. So when a set of workers connect to the ventilator, the first one to successfully connect will get a whole load of messages in that short time while the others are also connecting. If you don’t synchronize the start of the batch somehow, the system won’t run in parallel at all. Try removing the wait in the ventilator, and see what happens.

- The ventilator’s PUSH socket distributes tasks to workers (assuming they are all connected _before_ the batch starts going out) evenly. This is called _load balancing_ and it’s something we’ll look at again in more detail.

- The sink’s PULL socket collects results from workers evenly. This is called _fair-queuing_.


**Figure 6 - Fair Queuing**

![](https://zguide.zeromq.org/images/fig6.png)

The pipeline pattern also exhibits the “slow joiner” syndrome, leading to accusations that PUSH sockets don’t load balance properly. If you are using PUSH and PULL, and one of your workers gets way more messages than the others, it’s because that PULL socket has joined faster than the others, and grabs a lot of messages before the others manage to connect. If you want proper load balancing, you probably want to look at the load balancing pattern in
[Chapter 3 - Advanced Request-Reply Patterns](https://zguide.zeromq.org/docs/chapter3/#advanced-request-reply).

## Programming with ZeroMQ  [\#](https://zguide.zeromq.org/docs/chapter1/\#Programming-with-ZeroMQ)

Having seen some examples, you must be eager to start using ZeroMQ in some apps. Before you start that, take a deep breath, chillax, and reflect on some basic advice that will save you much stress and confusion.

- Learn ZeroMQ step-by-step. It’s just one simple API, but it hides a world of possibilities. Take the possibilities slowly and master each one.

- Write nice code. Ugly code hides problems and makes it hard for others to help you. You might get used to meaningless variable names, but people reading your code won’t. Use names that are real words, that say something other than “I’m too careless to tell you what this variable is really for”. Use consistent indentation and clean layout. Write nice code and your world will be more comfortable.

- Test what you make as you make it. When your program doesn’t work, you should know what five lines are to blame. This is especially true when you do ZeroMQ magic, which just _won’t_ work the first few times you try it.

- When you find that things don’t work as expected, break your code into pieces, test each one, see which one is not working. ZeroMQ lets you make essentially modular code; use that to your advantage.

- Make abstractions (classes, methods, whatever) as you need them. If you copy/paste a lot of code, you’re going to copy/paste errors, too.


### Getting the Context Right  [\#](https://zguide.zeromq.org/docs/chapter1/\#Getting-the-Context-Right)

ZeroMQ applications always start by creating a _context_, and then using that for creating sockets. In C, it’s the `
[zmq\_ctx\_new()](http://api.zeromq.org/master:zmq_ctx_new)` call. You should create and use exactly one context in your process. Technically, the context is the container for all sockets in a single process, and acts as the transport for `inproc` sockets, which are the fastest way to connect threads in one process. If at runtime a process has two contexts, these are like separate ZeroMQ instances. If that’s explicitly what you want, OK, but otherwise remember:

**Call `**
**[zmq\_ctx\_new()](http://api.zeromq.org/master:zmq_ctx_new)` once at the start of a process, and `**
**[zmq\_ctx\_destroy()](http://api.zeromq.org/master:zmq_ctx_destroy)` once at the end.**

If you’re using the `fork()` system call, do `
[zmq\_ctx\_new()](http://api.zeromq.org/master:zmq_ctx_new)` _after_ the fork and at the beginning of the child process code. In general, you want to do interesting (ZeroMQ) stuff in the children, and boring process management in the parent.

### Making a Clean Exit  [\#](https://zguide.zeromq.org/docs/chapter1/\#Making-a-Clean-Exit)

Classy programmers share the same motto as classy hit men: always clean-up when you finish the job. When you use ZeroMQ in a language like Python, stuff gets automatically freed for you. But when using C, you have to carefully free objects when you’re finished with them or else you get memory leaks, unstable applications, and generally bad karma.

Memory leaks are one thing, but ZeroMQ is quite finicky about how you exit an application. The reasons are technical and painful, but the upshot is that if you leave any sockets open, the `
[zmq\_ctx\_destroy()](http://api.zeromq.org/master:zmq_ctx_destroy)` function will hang forever. And even if you close all sockets, `
[zmq\_ctx\_destroy()](http://api.zeromq.org/master:zmq_ctx_destroy)` will by default wait forever if there are pending connects or sends unless you set the LINGER to zero on those sockets before closing them.

The ZeroMQ objects we need to worry about are messages, sockets, and contexts. Luckily it’s quite simple, at least in simple programs:

- Use `
    [zmq\_send()](http://api.zeromq.org/master:zmq_send)` and `
    [zmq\_recv()](http://api.zeromq.org/master:zmq_recv)` when you can, as it avoids the need to work with zmq\_msg\_t objects.

- If you do use `
    [zmq\_msg\_recv()](http://api.zeromq.org/master:zmq_msg_recv)`, always release the received message as soon as you’re done with it, by calling `
    [zmq\_msg\_close()](http://api.zeromq.org/master:zmq_msg_close)`.

- If you are opening and closing a lot of sockets, that’s probably a sign that you need to redesign your application. In some cases socket handles won’t be freed until you destroy the context.

- When you exit the program, close your sockets and then call `
    [zmq\_ctx\_destroy()](http://api.zeromq.org/master:zmq_ctx_destroy)`. This destroys the context.


This is at least the case for C development. In a language with automatic object destruction, sockets and contexts will be destroyed as you leave the scope. If you use exceptions you’ll have to do the clean-up in something like a “final” block, the same as for any resource.

If you’re doing multithreaded work, it gets rather more complex than this. We’ll get to multithreading in the next chapter, but because some of you will, despite warnings, try to run before you can safely walk, below is the quick and dirty guide to making a clean exit in a _multithreaded_ ZeroMQ application.

First, do not try to use the same socket from multiple threads. Please don’t explain why you think this would be excellent fun, just please don’t do it. Next, you need to shut down each socket that has ongoing requests. The proper way is to set a low LINGER value (1 second), and then close the socket. If your language binding doesn’t do this for you automatically when you destroy a context, I’d suggest sending a patch.

Finally, destroy the context. This will cause any blocking receives or polls or sends in attached threads (i.e., which share the same context) to return with an error. Catch that error, and then set linger on, and close sockets in _that_ thread, and exit. Do not destroy the same context twice. The `zmq_ctx_destroy` in the main thread will block until all sockets it knows about are safely closed.

Voila! It’s complex and painful enough that any language binding author worth his or her salt will do this automatically and make the socket closing dance unnecessary.

## Why We Needed ZeroMQ  [\#](https://zguide.zeromq.org/docs/chapter1/\#Why-We-Needed-ZeroMQ)

Now that you’ve seen ZeroMQ in action, let’s go back to the “why”.

Many applications these days consist of components that stretch across some kind of network, either a LAN or the Internet. So many application developers end up doing some kind of messaging. Some developers use message queuing products, but most of the time they do it themselves, using TCP or UDP. These protocols are not hard to use, but there is a great difference between sending a few bytes from A to B, and doing messaging in any kind of reliable way.

Let’s look at the typical problems we face when we start to connect pieces using raw TCP. Any reusable messaging layer would need to solve all or most of these:

- How do we handle I/O? Does our application block, or do we handle I/O in the background? This is a key design decision. Blocking I/O creates architectures that do not scale well. But background I/O can be very hard to do right.

- How do we handle dynamic components, i.e., pieces that go away temporarily? Do we formally split components into “clients” and “servers” and mandate that servers cannot disappear? What then if we want to connect servers to servers? Do we try to reconnect every few seconds?

- How do we represent a message on the wire? How do we frame data so it’s easy to write and read, safe from buffer overflows, efficient for small messages, yet adequate for the very largest videos of dancing cats wearing party hats?

- How do we handle messages that we can’t deliver immediately? Particularly, if we’re waiting for a component to come back online? Do we discard messages, put them into a database, or into a memory queue?

- Where do we store message queues? What happens if the component reading from a queue is very slow and causes our queues to build up? What’s our strategy then?

- How do we handle lost messages? Do we wait for fresh data, request a resend, or do we build some kind of reliability layer that ensures messages cannot be lost? What if that layer itself crashes?

- What if we need to use a different network transport. Say, multicast instead of TCP unicast? Or IPv6? Do we need to rewrite the applications, or is the transport abstracted in some layer?

- How do we route messages? Can we send the same message to multiple peers? Can we send replies back to an original requester?

- How do we write an API for another language? Do we re-implement a wire-level protocol or do we repackage a library? If the former, how can we guarantee efficient and stable stacks? If the latter, how can we guarantee interoperability?

- How do we represent data so that it can be read between different architectures? Do we enforce a particular encoding for data types? How far is this the job of the messaging system rather than a higher layer?

- How do we handle network errors? Do we wait and retry, ignore them silently, or abort?


Take a typical open source project like
[Hadoop Zookeeper](https://zookeeper.apache.org/) and read the C API code in `
[src/c/src/zookeeper.c](http://github.com/apache/zookeeper/blob/trunk/src/c/src/zookeeper.c)`. When I read this code, in January 2013, it was 4,200 lines of mystery and in there is an undocumented, client/server network communication protocol. I see it’s efficient because it uses `poll` instead of `select`. But really, Zookeeper should be using a generic messaging layer and an explicitly documented wire level protocol. It is incredibly wasteful for teams to be building this particular wheel over and over.

But how to make a reusable messaging layer? Why, when so many projects need this technology, are people still doing it the hard way by driving TCP sockets in their code, and solving the problems in that long list over and over?

It turns out that building reusable messaging systems is really difficult, which is why few FOSS projects ever tried, and why commercial messaging products are complex, expensive, inflexible, and brittle. In 2006, iMatix designed
[AMQP](http://www.amqp.org/) which started to give FOSS developers perhaps the first reusable recipe for a messaging system. AMQP works better than many other designs,
[but remains relatively complex, expensive, and brittle](https://web.archive.org/web/20190620095529/www.imatix.com/articles:whats-wrong-with-amqp). It takes weeks to learn to use, and months to create stable architectures that don’t crash when things get hairy.

**Figure 7 - Messaging as it Starts**

![](https://zguide.zeromq.org/images/fig7.png)

Most messaging projects, like AMQP, that try to solve this long list of problems in a reusable way do so by inventing a new concept, the “broker”, that does addressing, routing, and queuing. This results in a client/server protocol or a set of APIs on top of some undocumented protocol that allows applications to speak to this broker. Brokers are an excellent thing in reducing the complexity of large networks. But adding broker-based messaging to a product like Zookeeper would make it worse, not better. It would mean adding an additional big box, and a new single point of failure. A broker rapidly becomes a bottleneck and a new risk to manage. If the software supports it, we can add a second, third, and fourth broker and make some failover scheme. People do this. It creates more moving pieces, more complexity, and more things to break.

And a broker-centric setup needs its own operations team. You literally need to watch the brokers day and night, and beat them with a stick when they start misbehaving. You need boxes, and you need backup boxes, and you need people to manage those boxes. It is only worth doing for large applications with many moving pieces, built by several teams of people over several years.

**Figure 8 - Messaging as it Becomes**

![](https://zguide.zeromq.org/images/fig8.png)

So small to medium application developers are trapped. Either they avoid network programming and make monolithic applications that do not scale. Or they jump into network programming and make brittle, complex applications that are hard to maintain. Or they bet on a messaging product, and end up with scalable applications that depend on expensive, easily broken technology. There has been no really good choice, which is maybe why messaging is largely stuck in the last century and stirs strong emotions: negative ones for users, gleeful joy for those selling support and licenses.

What we need is something that does the job of messaging, but does it in such a simple and cheap way that it can work in any application, with close to zero cost. It should be a library which you just link, without any other dependencies. No additional moving pieces, so no additional risk. It should run on any OS and work with any programming language.

And this is ZeroMQ: an efficient, embeddable library that solves most of the problems an application needs to become nicely elastic across a network, without much cost.

Specifically:

- It handles I/O asynchronously, in background threads. These communicate with application threads using lock-free data structures, so concurrent ZeroMQ applications need no locks, semaphores, or other wait states.

- Components can come and go dynamically and ZeroMQ will automatically reconnect. This means you can start components in any order. You can create “service-oriented architectures” (SOAs) where services can join and leave the network at any time.

- It queues messages automatically when needed. It does this intelligently, pushing messages as close as possible to the receiver before queuing them.

- It has ways of dealing with over-full queues (called “high water mark”). When a queue is full, ZeroMQ automatically blocks senders, or throws away messages, depending on the kind of messaging you are doing (the so-called “pattern”).

- It lets your applications talk to each other over arbitrary transports: TCP, multicast, in-process, inter-process. You don’t need to change your code to use a different transport.

- It handles slow/blocked readers safely, using different strategies that depend on the messaging pattern.

- It lets you route messages using a variety of patterns such as request-reply and pub-sub. These patterns are how you create the topology, the structure of your network.

- It lets you create proxies to queue, forward, or capture messages with a single call. Proxies can reduce the interconnection complexity of a network.

- It delivers whole messages exactly as they were sent, using a simple framing on the wire. If you write a 10k message, you will receive a 10k message.

- It does not impose any format on messages. They are blobs from zero to gigabytes large. When you want to represent data you choose some other product on top, such as msgpack, Google’s protocol buffers, and others.

- It handles network errors intelligently, by retrying automatically in cases where it makes sense.

- It reduces your carbon footprint. Doing more with less CPU means your boxes use less power, and you can keep your old boxes in use for longer. Al Gore would love ZeroMQ.


Actually ZeroMQ does rather more than this. It has a subversive effect on how you develop network-capable applications. Superficially, it’s a socket-inspired API on which you do `
[zmq\_recv()](http://api.zeromq.org/master:zmq_recv)` and `
[zmq\_send()](http://api.zeromq.org/master:zmq_send)`. But message processing rapidly becomes the central loop, and your application soon breaks down into a set of message processing tasks. It is elegant and natural. And it scales: each of these tasks maps to a node, and the nodes talk to each other across arbitrary transports. Two nodes in one process (node is a thread), two nodes on one box (node is a process), or two nodes on one network (node is a box)–it’s all the same, with no application code changes.

## Socket Scalability  [\#](https://zguide.zeromq.org/docs/chapter1/\#Socket-Scalability)

Let’s see ZeroMQ’s scalability in action. Here is a shell script that starts the weather server and then a bunch of clients in parallel:

```
wuserver &
wuclient 12345 &
wuclient 23456 &
wuclient 34567 &
wuclient 45678 &
wuclient 56789 &
```

As the clients run, we take a look at the active processes using the `top` command’, and we see something like (on a 4-core box):

```
PID  USER  PR  NI  VIRT  RES  SHR S %CPU %MEM   TIME+  COMMAND
7136  ph   20   0 1040m 959m 1156 R  157 12.0 16:25.47 wuserver
7966  ph   20   0 98608 1804 1372 S   33  0.0  0:03.94 wuclient
7963  ph   20   0 33116 1748 1372 S   14  0.0  0:00.76 wuclient
7965  ph   20   0 33116 1784 1372 S    6  0.0  0:00.47 wuclient
7964  ph   20   0 33116 1788 1372 S    5  0.0  0:00.25 wuclient
7967  ph   20   0 33072 1740 1372 S    5  0.0  0:00.35 wuclient
```

Let’s think for a second about what is happening here. The weather server has a single socket, and yet here we have it sending data to five clients in parallel. We could have thousands of concurrent clients. The server application doesn’t see them, doesn’t talk to them directly. So the ZeroMQ socket is acting like a little server, silently accepting client requests and shoving data out to them as fast as the network can handle it. And it’s a multithreaded server, squeezing more juice out of your CPU.

## Upgrading from ZeroMQ v2.2 to ZeroMQ v3.2  [\#](https://zguide.zeromq.org/docs/chapter1/\#Upgrading-from-ZeroMQ-v-to-ZeroMQ-v)

### Compatible Changes  [\#](https://zguide.zeromq.org/docs/chapter1/\#Compatible-Changes)

These changes don’t impact existing application code directly:

- Pub-sub filtering is now done at the publisher side instead of subscriber side. This improves performance significantly in many pub-sub use cases. You can mix v3.2 and v2.1/v2.2 publishers and subscribers safely.

- ZeroMQ v3.2 has many new API methods ( `
    [zmq\_disconnect()](http://api.zeromq.org/master:zmq_disconnect)`, `
    [zmq\_unbind()](http://api.zeromq.org/master:zmq_unbind)`, `
    [zmq\_monitor()](http://api.zeromq.org/master:zmq_monitor)`, `
    [zmq\_ctx\_set()](http://api.zeromq.org/master:zmq_ctx_set)`, etc.)


### Incompatible Changes  [\#](https://zguide.zeromq.org/docs/chapter1/\#Incompatible-Changes)

These are the main areas of impact on applications and language bindings:

- Changed send/recv methods: `
    [zmq\_send()](http://api.zeromq.org/master:zmq_send)` and `
    [zmq\_recv()](http://api.zeromq.org/master:zmq_recv)` have a different, simpler interface, and the old functionality is now provided by `
    [zmq\_msg\_send()](http://api.zeromq.org/master:zmq_msg_send)` and `
    [zmq\_msg\_recv()](http://api.zeromq.org/master:zmq_msg_recv)`. Symptom: compile errors. Solution: fix up your code.

- These two methods return positive values on success, and -1 on error. In v2.x they always returned zero on success. Symptom: apparent errors when things actually work fine. Solution: test strictly for return code = -1, not non-zero.

- `
    [zmq\_poll()](http://api.zeromq.org/master:zmq_poll)` now waits for milliseconds, not microseconds. Symptom: application stops responding (in fact responds 1000 times slower). Solution: use the `ZMQ_POLL_MSEC` macro defined below, in all `zmq_poll` calls.

- `ZMQ_NOBLOCK` is now called `ZMQ_DONTWAIT`. Symptom: compile failures on the `ZMQ_NOBLOCK` macro.

- The `ZMQ_HWM` socket option is now broken into `ZMQ_SNDHWM` and `ZMQ_RCVHWM`. Symptom: compile failures on the `ZMQ_HWM` macro.

- Most but not all `
    [zmq\_getsockopt()](http://api.zeromq.org/master:zmq_getsockopt)` options are now integer values. Symptom: runtime error returns on `zmq_setsockopt` and `zmq_getsockopt`.

- The `ZMQ_SWAP` option has been removed. Symptom: compile failures on `ZMQ_SWAP`. Solution: redesign any code that uses this functionality.


### Suggested Shim Macros  [\#](https://zguide.zeromq.org/docs/chapter1/\#Suggested-Shim-Macros)

For applications that want to run on both v2.x and v3.2, such as language bindings, our advice is to emulate v3.2 as far as possible. Here are C macro definitions that help your C/C++ code to work across both versions (taken from
[CZMQ](http://czmq.zeromq.org/)):

```c

#ifndef ZMQ_DONTWAIT
#   define ZMQ_DONTWAIT     ZMQ_NOBLOCK
#endif
#if ZMQ_VERSION_MAJOR == 2
#   define zmq_msg_send(msg,sock,opt) zmq_send (sock, msg, opt)
#   define zmq_msg_recv(msg,sock,opt) zmq_recv (sock, msg, opt)
#   define zmq_ctx_destroy(context) zmq_term(context)
#   define ZMQ_POLL_MSEC    1000        //  zmq_poll is usec
#   define ZMQ_SNDHWM ZMQ_HWM
#   define ZMQ_RCVHWM ZMQ_HWM
#elif ZMQ_VERSION_MAJOR == 3
#   define ZMQ_POLL_MSEC    1           //  zmq_poll is msec
#endif
```

## Warning: Unstable Paradigms!  [\#](https://zguide.zeromq.org/docs/chapter1/\#Warning-Unstable-Paradigms)

Traditional network programming is built on the general assumption that one socket talks to one connection, one peer. There are multicast protocols, but these are exotic. When we assume “one socket = one connection”, we scale our architectures in certain ways. We create threads of logic where each thread work with one socket, one peer. We place intelligence and state in these threads.

In the ZeroMQ universe, sockets are doorways to fast little background communications engines that manage a whole set of connections automagically for you. You can’t see, work with, open, close, or attach state to these connections. Whether you use blocking send or receive, or poll, all you can talk to is the socket, not the connections it manages for you. The connections are private and invisible, and this is the key to ZeroMQ’s scalability.

This is because your code, talking to a socket, can then handle any number of connections across whatever network protocols are around, without change. A messaging pattern sitting in ZeroMQ scales more cheaply than a messaging pattern sitting in your application code.

So the general assumption no longer applies. As you read the code examples, your brain will try to map them to what you know. You will read “socket” and think “ah, that represents a connection to another node”. That is wrong. You will read “thread” and your brain will again think, “ah, a thread represents a connection to another node”, and again your brain will be wrong.

If you’re reading this Guide for the first time, realize that until you actually write ZeroMQ code for a day or two (and maybe three or four days), you may feel confused, especially by how simple ZeroMQ makes things for you, and you may try to impose that general assumption on ZeroMQ, and it won’t work. And then you will experience your moment of enlightenment and trust, that _zap-pow-kaboom_ satori paradigm-shift moment when it all becomes clear.

[![Edit](https://zguide.zeromq.org/svg/edit.svg)Edit this page](https://github.com/booksbyus/zguide/edit/master/site/content/docs/chapter1.md)

- [Fixing the World](https://zguide.zeromq.org/docs/chapter1/#Fixing-the-World)
- [Starting Assumptions](https://zguide.zeromq.org/docs/chapter1/#Starting-Assumptions)
- [Getting the Examples](https://zguide.zeromq.org/docs/chapter1/#Getting-the-Examples)
- [Ask and Ye Shall Receive](https://zguide.zeromq.org/docs/chapter1/#Ask-and-Ye-Shall-Receive)
- [A Minor Note on Strings](https://zguide.zeromq.org/docs/chapter1/#A-Minor-Note-on-Strings)
- [A Note on the Naming Convention](https://zguide.zeromq.org/docs/chapter1/#A-Note-on-the-Naming-Convention)
- [Version Reporting](https://zguide.zeromq.org/docs/chapter1/#Version-Reporting)
- [Getting the Message Out](https://zguide.zeromq.org/docs/chapter1/#Getting-the-Message-Out)
- [Divide and Conquer](https://zguide.zeromq.org/docs/chapter1/#Divide-and-Conquer)
- [Programming with ZeroMQ](https://zguide.zeromq.org/docs/chapter1/#Programming-with-ZeroMQ)
  - [Getting the Context Right](https://zguide.zeromq.org/docs/chapter1/#Getting-the-Context-Right)
  - [Making a Clean Exit](https://zguide.zeromq.org/docs/chapter1/#Making-a-Clean-Exit)
- [Why We Needed ZeroMQ](https://zguide.zeromq.org/docs/chapter1/#Why-We-Needed-ZeroMQ)
- [Socket Scalability](https://zguide.zeromq.org/docs/chapter1/#Socket-Scalability)
- [Upgrading from ZeroMQ v2.2 to ZeroMQ v3.2](https://zguide.zeromq.org/docs/chapter1/#Upgrading-from-ZeroMQ-v-to-ZeroMQ-v)
  - [Compatible Changes](https://zguide.zeromq.org/docs/chapter1/#Compatible-Changes)
  - [Incompatible Changes](https://zguide.zeromq.org/docs/chapter1/#Incompatible-Changes)
  - [Suggested Shim Macros](https://zguide.zeromq.org/docs/chapter1/#Suggested-Shim-Macros)
- [Warning: Unstable Paradigms!](https://zguide.zeromq.org/docs/chapter1/#Warning-Unstable-Paradigms)