#charset "us-ascii"
//
// bind.t
//
//	A TADS3/adv3 module providing a mechanism for binding a method to
//	a context.
//
//
// USAGE
//
//	Bind a method to a context using bind():
//
//		// fn is the foozle method on foo.
//		local fn = bind(&foozle, foo);
//
//		// call the bound method, equivalent to foo.foozle()
//		fn();
//
//	Additionally bind arguments:
//
//		// fn() will be foo.foozle('bar')
//		local fn = bind(&foozle, foo, 'bar');
//		fn();
//
//
#include <adv3.h>
#include <en_us.h>

// Module ID for the library
bindModuleID: ModuleID {
        name = 'Bind Library'
        byline = 'Diegesis & Mimesis'
        version = '1.0'
        listingOrder = 99
}

class Bind: object
	fn = nil
	ctx = nil
	args = nil
	construct(cb, obj, [argList]) {
		fn = cb;
		ctx = obj;
		args = argList;
	}
	execute() { (ctx).(fn)(args); }
;

bind(cb, obj, [args]) {
	if((obj == nil) || !obj.ofKind(Object))
		return(nil);
	if((cb == nil) || (dataTypeXlat(cb) != TypeProp))
		return(nil);
	return(function() { (new Bind(cb, obj, args...)).execute(); });
}
