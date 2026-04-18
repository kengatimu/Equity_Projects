// Array.pop() - Remove and return the last element of an array
if( typeof Array.prototype.pop==='undefined' ) {
 Array.prototype.pop = function() {
  var b = this[this.length-1];
  this.length--;
  return b;
 };
}

// Array.push() - Add an element to the end of an array, return the new length
if( typeof Array.prototype.push==='undefined' ) {
 Array.prototype.push = function() {
  for( var i = 0, b = this.length, a = arguments, l = a.length; i<l; i++ ) {
   this[b+i] = a[i];
  }
  return this.length;
 };
}

// Array.indexOf( value, begin, strict ) - Return index of the first element that matches value
Array.prototype.indexOf = function( v, b, s ) {
 for( var i = +b || 0, l = this.length; i < l; i++ ) {
  if( this[i]===v || s && this[i]==v ) { return i; }
 }
 return -1;
};

// Array.lastIndexOf( value, begin, strict ) - Return index of the last element that matches value
Array.prototype.lastIndexOf = function( v, b, s ) {
 b = +b || 0;
 var i = this.length; while(i-->b) {
  if( this[i]===v || s && this[i]==v ) { return i; }
 }
 return -1;
};

// Array.unique( strict ) - Remove duplicate values
Array.prototype.unique = function( b ) {
 var a = [], i, l = this.length;
 for( i=0; i<l; i++ ) {
  if( a.indexOf( this[i], 0, b ) < 0 ) { a.push(this[i] ); }
 }
 return a;
};

// Array.uniqueIndex( strict ) - Remove duplicate values
Array.prototype.uniqueIndex = function( b ) {
 var a = [],ind = [], i, l = this.length;
 for( i=0; i<l; i++ ) {
  if( a.indexOf( this[i], 0, b ) < 0 ) {  a.push( this[i] );} else { ind.push(i); }
 }
 return ind;
};

// Array.walk() - Change each value according to a callback function
Array.prototype.walk = function( f ) {
 var a = [], i = this.length;
 while(i--) { a.push( f( this[i] ) ); }
 return a.reverse();
};

//---- String prototypes -----

String.prototype.trim = function() {
	return this.replace(/^\s+|\s+$/g,"");
}

String.prototype.ltrim = function() {
	return this.replace(/^\s+/,"");
}
String.prototype.rtrim = function() {
	return this.replace(/\s+$/,"");
}

