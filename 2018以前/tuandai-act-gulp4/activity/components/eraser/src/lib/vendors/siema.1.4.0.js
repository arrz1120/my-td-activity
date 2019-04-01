function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }
var SiemaPrevent = function () {
  function SiemaPrevent(options) {
    var _this3 = this;

    _classCallCheck(this, SiemaPrevent);

    // Merge defaults with user's settings
    this.config = SiemaPrevent.mergeSettings(options);

    // Create global references
    this.selector = typeof this.config.selector === 'string' ? document.querySelector(this.config.selector) : this.config.selector;
    this.selectorWidth = this.selector.getBoundingClientRect().width;
    this.innerElements = [].slice.call(this.selector.children);
    this.currentSlide = this.config.startIndex;
    this.transformProperty = SiemaPrevent.webkitOrNot();

    // Bind all event handlers for referencability
    ['resizeHandler', 'touchstartHandler', 'touchendHandler', 'touchmoveHandler', 'mousedownHandler', 'mouseupHandler', 'mouseleaveHandler', 'mousemoveHandler'].forEach(function (method) {
      _this3[method] = _this3[method].bind(_this3);
    });

    // Build markup and apply required styling to elements
    this.init();
  }

  SiemaPrevent.mergeSettings = function mergeSettings(options) {
    var settings = {
      selector: '.siema',
      duration: 200,
      easing: 'ease-out',
      perPage: 1,
      startIndex: 0,
      draggable: true,
      threshold: 20,
      loop: false,
      onInit: function onInit() {},
      onChange: function onChange() {},
      onDestroy: function onDestroy() {}
    };
    var userSttings = options;
    for (var attrname in userSttings) {
      settings[attrname] = userSttings[attrname];
    }
    return settings;
  };

  SiemaPrevent.webkitOrNot = function webkitOrNot() {
    var style = document.documentElement.style;
    if (typeof style.transform == 'string') {
      return 'transform';
    }
    return 'WebkitTransform';
  };

  SiemaPrevent.prototype.init = function init() {
    // Resize element on window resize
    window.addEventListener('resize', this.resizeHandler);

    // If element is draggable / swipable, add event handlers
    if (this.config.draggable) {
      // Keep track pointer hold and dragging distance
      this.pointerDown = false;
      this.drag = {
        startX: 0,
        endX: 0,
        startY: 0,
        letItGo: null
      };

      // Touch events
      this.selector.addEventListener('touchstart', this.touchstartHandler);
      this.selector.addEventListener('touchend', this.touchendHandler);
      this.selector.addEventListener('touchmove', this.touchmoveHandler);

      // Mouse events
      this.selector.addEventListener('mousedown', this.mousedownHandler);
      this.selector.addEventListener('mouseup', this.mouseupHandler);
      this.selector.addEventListener('mouseleave', this.mouseleaveHandler);
      this.selector.addEventListener('mousemove', this.mousemoveHandler);
    }

    if (this.selector === null) {
      throw new Error('Something wrong with your selector 😭');
    }

    // update perPage number dependable of user value
    this.resolveSlidesNumber();

    // hide everything out of selector's boundaries
    this.selector.style.overflow = 'hidden';

    // Create frame and apply styling
    this.sliderFrame = document.createElement('div');
    this.sliderFrame.style.width = this.selectorWidth / this.perPage * this.innerElements.length + 'px';
    this.sliderFrame.style.webkitTransition = 'all ' + this.config.duration + 'ms ' + this.config.easing;
    this.sliderFrame.style.transition = 'all ' + this.config.duration + 'ms ' + this.config.easing;

    if (this.config.draggable) {
      this.sliderFrame.style.cursor = '-webkit-grab';
    }

    // Create a document fragment to put slides into it
    var docFragment = document.createDocumentFragment();

    // Loop through the slides, add styling and add them to document fragment
    for (var i = 0; i < this.innerElements.length; i++) {
      var elementContainer = document.createElement('div');
      elementContainer.style.cssFloat = 'left';
      elementContainer.style.float = 'left';
      elementContainer.style.width = 100 / this.innerElements.length + '%';
      elementContainer.appendChild(this.innerElements[i]);
      docFragment.appendChild(elementContainer);
    }

    // Add fragment to frame
    this.sliderFrame.appendChild(docFragment);

    // Clear selector (just in case something exists there) and append a frame
    this.selector.innerHTML = '';
    this.selector.appendChild(this.sliderFrame);

    // Go to currently active slide after initial build
    this.slideToCurrent();
    this.config.onInit.call(this);
  };

  // Determinate slides number

  SiemaPrevent.prototype.resolveSlidesNumber = function resolveSlidesNumber() {
    if (typeof this.config.perPage === 'number') {
      this.perPage = this.config.perPage;
    } else if (_typeof(this.config.perPage) === 'object') {
      this.perPage = 1;
      for (var viewport in this.config.perPage) {
        if (window.innerWidth >= viewport) {
          this.perPage = this.config.perPage[viewport];
        }
      }
    }
  };

  // Go to previous slide

  SiemaPrevent.prototype.prev = function prev() {
    var howManySlides = arguments.length <= 0 || arguments[0] === undefined ? 1 : arguments[0];

    if (this.currentSlide === 0 && this.config.loop) {
      this.currentSlide = this.innerElements.length - this.perPage;
    } else {
      this.currentSlide = Math.max(this.currentSlide - howManySlides, 0);
    }
    this.slideToCurrent();
    this.config.onChange.call(this);
  };

  // Go to Next slide

  SiemaPrevent.prototype.next = function next() {
    var howManySlides = arguments.length <= 0 || arguments[0] === undefined ? 1 : arguments[0];

    if (this.currentSlide === this.innerElements.length - this.perPage && this.config.loop) {
      this.currentSlide = 0;
    } else {
      this.currentSlide = Math.min(this.currentSlide + howManySlides, this.innerElements.length - this.perPage);
    }
    this.slideToCurrent();
    this.config.onChange.call(this);
  };

  // Go to slide with particular index

  SiemaPrevent.prototype.goTo = function goTo(index) {
    this.currentSlide = Math.min(Math.max(index, 0), this.innerElements.length - 1);
    this.slideToCurrent();
  };

  // Move slider frame to correct position depending on currently active slide

  SiemaPrevent.prototype.slideToCurrent = function slideToCurrent() {
    this.sliderFrame.style[this.transformProperty] = 'translate3d(-' + this.currentSlide * (this.selectorWidth / this.perPage) + 'px, 0, 0)';
  };

  // Recalculate drag /swipe event and reposition the frame of a slider

  SiemaPrevent.prototype.updateAfterDrag = function updateAfterDrag() {
    var movement = this.drag.endX - this.drag.startX;
    var movementDistance = Math.abs(movement);
    var howManySliderToSlide = Math.ceil(movementDistance / (this.selectorWidth / this.perPage));

    if (movement > 0 && movementDistance > this.config.threshold) {
      this.prev(howManySliderToSlide);
    } else if (movement < 0 && movementDistance > this.config.threshold) {
      this.next(howManySliderToSlide);
    }
    this.slideToCurrent();
  };

  // When window resizes, resize slider components as well

  SiemaPrevent.prototype.resizeHandler = function resizeHandler() {
    // update perPage number dependable of user value
    this.resolveSlidesNumber();

    this.selectorWidth = this.selector.getBoundingClientRect().width;
    this.sliderFrame.style.width = this.selectorWidth / this.perPage * this.innerElements.length + 'px';

    this.slideToCurrent();
  };

  // Clear drag

  SiemaPrevent.prototype.clearDrag = function clearDrag() {
    this.drag = {
      startX: 0,
      endX: 0,
      startY: 0,
      letItGo: null
    };
  };

  // Touch events handlers

  SiemaPrevent.prototype.touchstartHandler = function touchstartHandler(e) {
    e.stopPropagation();
    this.pointerDown = true;
    this.drag.startX = e.touches[0].pageX;
    this.drag.startY = e.touches[0].pageY;
  };

  SiemaPrevent.prototype.touchendHandler = function touchendHandler(e) {
    e.stopPropagation();
    this.pointerDown = false;
    this.sliderFrame.style.webkitTransition = 'all ' + this.config.duration + 'ms ' + this.config.easing;
    this.sliderFrame.style.transition = 'all ' + this.config.duration + 'ms ' + this.config.easing;
    if (this.drag.endX) {
      this.updateAfterDrag();
    }
    this.clearDrag();
  };

  SiemaPrevent.prototype.touchmoveHandler = function touchmoveHandler(e) {
    e.stopPropagation();

    if (this.drag.letItGo === null) {
      this.drag.letItGo = Math.abs(this.drag.startY - e.touches[0].pageY) < Math.abs(this.drag.startX - e.touches[0].pageX);
    }

    if (this.pointerDown && this.drag.letItGo) {
      e.preventDefault();
      this.drag.endX = e.touches[0].pageX;
      this.sliderFrame.style.webkitTransition = 'all 0ms ' + this.config.easing;
      this.sliderFrame.style.transition = 'all 0ms ' + this.config.easing;
      this.sliderFrame.style[this.transformProperty] = 'translate3d(' + (this.currentSlide * (this.selectorWidth / this.perPage) + (this.drag.startX - this.drag.endX)) * -1 + 'px, 0, 0)';
    }
  };

  // Mouse events handlers

  SiemaPrevent.prototype.mousedownHandler = function mousedownHandler(e) {
    e.preventDefault();
    e.stopPropagation();
    this.pointerDown = true;
    this.drag.startX = e.pageX;
  };

  SiemaPrevent.prototype.mouseupHandler = function mouseupHandler(e) {
    e.stopPropagation();
    this.pointerDown = false;
    this.sliderFrame.style.cursor = '-webkit-grab';
    this.sliderFrame.style.webkitTransition = 'all ' + this.config.duration + 'ms ' + this.config.easing;
    this.sliderFrame.style.transition = 'all ' + this.config.duration + 'ms ' + this.config.easing;
    if (this.drag.endX) {
      this.updateAfterDrag();
    }
    this.clearDrag();
  };

  SiemaPrevent.prototype.mousemoveHandler = function mousemoveHandler(e) {
    e.preventDefault();
    if (this.pointerDown) {
      this.drag.endX = e.pageX;
      this.sliderFrame.style.cursor = '-webkit-grabbing';
      this.sliderFrame.style.webkitTransition = 'all 0ms ' + this.config.easing;
      this.sliderFrame.style.transition = 'all 0ms ' + this.config.easing;
      this.sliderFrame.style[this.transformProperty] = 'translate3d(' + (this.currentSlide * (this.selectorWidth / this.perPage) + (this.drag.startX - this.drag.endX)) * -1 + 'px, 0, 0)';
    }
  };

  SiemaPrevent.prototype.mouseleaveHandler = function mouseleaveHandler(e) {
    if (this.pointerDown) {
      this.pointerDown = false;
      this.sliderFrame.style.cursor = '-webkit-grab';
      this.drag.endX = e.pageX;
      this.sliderFrame.style.webkitTransition = 'all ' + this.config.duration + 'ms ' + this.config.easing;
      this.sliderFrame.style.transition = 'all ' + this.config.duration + 'ms ' + this.config.easing;
      this.updateAfterDrag();
      this.clearDrag();
    }
  };

  // Destroy - remove listeners to prevent from memory leak (and revert to original markup)

  SiemaPrevent.prototype.destroy = function destroy() {
    var restoreMarkup = arguments.length <= 0 || arguments[0] === undefined ? false : arguments[0];

    window.removeEventListener('resize', this.resizeHandler);
    this.selector.removeEventListener('touchstart', this.touchstartHandler);
    this.selector.removeEventListener('touchend', this.touchendHandler);
    this.selector.removeEventListener('touchmove', this.touchmoveHandler);
    this.selector.removeEventListener('mousedown', this.mousedownHandler);
    this.selector.removeEventListener('mouseup', this.mouseupHandler);
    this.selector.removeEventListener('mouseleave', this.mouseleaveHandler);
    this.selector.removeEventListener('mousemove', this.mousemoveHandler);

    if (restoreMarkup) {
      var slides = document.createDocumentFragment();
      for (var i = 0; i < this.innerElements.length; i++) {
        slides.appendChild(this.innerElements[i]);
      }
      this.selector.innerHTML = '';
      this.selector.appendChild(slides);
      this.selector.removeAttribute('style');
    }

    this.config.onDestroy.call(this);
  };

  return SiemaPrevent;
}();

export default SiemaPrevent