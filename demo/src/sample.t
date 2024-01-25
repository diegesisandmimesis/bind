#charset "us-ascii"
//
// sample.t
// Version 1.0
// Copyright 2022 Diegesis & Mimesis
//
// This is a very simple demonstration "game" for the bind library.
//
// It can be compiled via the included makefile with
//
//	# t3make -f makefile.t3m
//
// ...or the equivalent, depending on what TADS development environment
// you're using.
//
// This "game" is distributed under the MIT License, see LICENSE.txt
// for details.
//
#include <adv3.h>
#include <en_us.h>

#include "bind.h"

versionInfo: GameID
        name = 'bind Library Demo Game'
        byline = 'Diegesis & Mimesis'
        desc = 'Demo game for the bind library. '
        version = '1.0'
        IFID = '12345'
	showAbout() {
		"This is a simple test game that demonstrates the features
		of the bind library.
		<.p>
		Consult the README.txt document distributed with the library
		source for a quick summary of how to use the library in your
		own games.
		<.p>
		The library source is also extensively commented in a way
		intended to make it as readable as possible. ";
	}
;
gameMain: GameMainDef
	initialPlayerChar = me
	inlineCommand(cmd) { "<b>&gt;<<toString(cmd).toUpper()>></b>"; }
	printCommand(cmd) { "<.p>\n\t<<inlineCommand(cmd)>><.p> "; }

	showIntro() {
		"This demo provides a <<inlineCommand('foozle')>> command
		that will call bound methods in a few different ways.
		<.p> ";
	}
;

startRoom: Room 'Void' "This is a featureless void.";
+me: Person;

foo: object
	foozle(arg0, arg1) {
		"\ncalled foozle(\'<<toString(arg0)>>\',
			\'<<toString(arg1)>>\')\n ";
	}
;

DefineSystemAction(Foozle)
	execSystemAction() {
		local fn;

		fn = bind(&foozle, foo, 'foo0', 'bar0');
		fn();

		fn = bind(&foozle, foo);
		fn('foo1', 'bar1');

		fn = bind(&foozle, foo, 'foo2');
		fn('bar2');
	}
;
VerbRule(Foozle) 'foozle': FoozleAction VerbPhrase = 'foozle/foozling';
