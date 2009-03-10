Effect.MoveAndResizeTo = Class.create();
Object.extend(Object.extend(Effect.MoveAndResizeTo.prototype, Effect.Base.prototype), {
  initialize: function(element, toTop, toLeft, toWidth, toHeight) {

    this.element      = $(element);
    this.toTop        = toTop;
    this.toLeft       = toLeft;
    this.toWidth      = toWidth;
    this.toHeight     = toHeight;


    this.originalTop  = parseFloat(Element.getStyle(this.element,'top')  || 0);
    this.originalLeft = parseFloat(Element.getStyle(this.element,'left') || 0);
    this.originalWidth  = parseFloat(Element.getStyle(this.element,'width')  || 0);
    this.originalHeight = parseFloat(Element.getStyle(this.element,'height') || 0);

    this.effectiveTop = this.toTop;

    this.effectiveLeft = this.toLeft;

    this.effectiveWidth = this.toWidth 
                        - parseFloat(Element.getStyle(this.element,'margin-left') || 0) 
                        - parseFloat(Element.getStyle(this.element,'margin-right') || 0) 
                        - (document.compatMode == 'BackCompat' ? 0 : // height includes padding & border in IE BackCompat mode
                            parseFloat(Element.getStyle(this.element,'padding-left') || 0) 
                            + parseFloat(Element.getStyle(this.element,'padding-right') || 0) 
                            + parseFloat(Element.getStyle(this.element,'border-left-width') || 0)
                            + parseFloat(Element.getStyle(this.element,'border-right-width') || 0));


    this.effectiveHeight = this.toHeight
                        - parseFloat(Element.getStyle(this.element,'margin-top') || 0) 
                        - parseFloat(Element.getStyle(this.element,'margin-bottom') || 0) 
                        - (document.compatMode == 'BackCompat' ? 0 : // height includes padding & border in IE BackCompat mode
                            parseFloat(Element.getStyle(this.element,'padding-top') || 0) 
                            + parseFloat(Element.getStyle(this.element,'padding-bottom') || 0) 
                            + parseFloat(Element.getStyle(this.element,'border-top-width') || 0)
                            + parseFloat(Element.getStyle(this.element,'border-bottom-width') || 0));

    this.options = arguments[5] || {};

    if (this.effectiveWidth < 0) this.effectiveWidth = 0;
    if (this.effectiveHeight < 0) this.effectiveHeight = 0;

    if (this.originalTop == this.effectiveTop &&
        this.originalLeft == this.effectiveLeft &&
        this.originalWidth == this.effectiveWidth &&
        this.originalHeight == this.effectiveHeight) {

      // no need to start!
      return;
    }

    this.start(this.options);

  },
  update: function(position) {
    topd  = this.effectiveTop * (position) + this.originalTop * (1 - position);
    leftd = this.effectiveLeft * (position) + this.originalLeft * (1 - position);
    widthd  = this.effectiveWidth * (position) + this.originalWidth * (1 - position);
    heightd = this.effectiveHeight * (position) + this.originalHeight * (1 - position);
    this.setPosition(topd, leftd, widthd, heightd);
  },
  setPosition: function(topd, leftd, widthd, heightd) {

    this.element.style.top = topd+'px';
    this.element.style.left = leftd+'px';
    this.element.style.width = widthd+'px';
    this.element.style.height = heightd+'px';
  }
});


Effect.ResizeTo = Class.create();
Object.extend(Object.extend(Effect.ResizeTo.prototype, Effect.Base.prototype), {
  initialize: function(element, toWidth, toHeight) {

    this.element      = $(element);
    this.toWidth      = toWidth;
    this.toHeight     = toHeight;

    this.originalWidth  = parseFloat(Element.getStyle(this.element,'width')  || 0);
    this.originalHeight = parseFloat(Element.getStyle(this.element,'height') || 0);

    this.effectiveWidth = this.toWidth 
                        - parseFloat(Element.getStyle(this.element,'margin-left') || 0) 
                        - parseFloat(Element.getStyle(this.element,'margin-right') || 0) 
                        - (document.compatMode == 'BackCompat' ? 0 : // height includes padding & border in IE BackCompat mode
                            parseFloat(Element.getStyle(this.element,'padding-left') || 0) 
                            + parseFloat(Element.getStyle(this.element,'padding-right') || 0) 
                            + parseFloat(Element.getStyle(this.element,'border-left-width') || 0)
                            + parseFloat(Element.getStyle(this.element,'border-right-width') || 0));

    this.effectiveHeight = this.toHeight
                        - parseFloat(Element.getStyle(this.element,'margin-top') || 0) 
                        - parseFloat(Element.getStyle(this.element,'margin-bottom') || 0) 
                        - (document.compatMode == 'BackCompat' ? 0 : // height includes padding & border in IE BackCompat mode
                            parseFloat(Element.getStyle(this.element,'padding-top') || 0) 
                            + parseFloat(Element.getStyle(this.element,'padding-bottom') || 0) 
                            + parseFloat(Element.getStyle(this.element,'border-top-width') || 0)
                            + parseFloat(Element.getStyle(this.element,'border-bottom-width') || 0));

    this.options = arguments[3] || {};

    if (this.effectiveWidth < 0) this.effectiveWidth = 0;
    if (this.effectiveHeight < 0) this.effectiveHeight = 0;

    if (this.originalWidth == this.effectiveWidth && this.originalHeight == this.effectiveHeight) {
      return;
    }
	

this.start(this.options);

},
update: function(position) {
  widthd  = this.effectiveWidth * (position) + this.originalWidth * (1 - position);
  heightd = this.effectiveHeight * (position) + this.originalHeight * (1 - position);
  this.setPosition(widthd, heightd);
},
setPosition: function(widthd, heightd) {
  this.element.style.width = widthd+'px';
  this.element.style.height = heightd+'px';
}
});
