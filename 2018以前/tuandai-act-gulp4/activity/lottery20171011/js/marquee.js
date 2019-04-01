'use strict';

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

var Marquee = function () {
  function Marquee(el, opts) {
    _classCallCheck(this, Marquee);

    this.el = typeof el === 'string' ? document.querySelector(el) : el;
    opts = opts == null ? {} : opts;
    this.opts = Marquee.mergeOpts(opts);
    this.timerCount = 0;
    this.el.style.transform = this.el.style.webkitTransform = 'translateX(0)';
    this.el.style.overflow = 'hidden';
    this.init();
  }

  _createClass(Marquee, [{
    key: 'init',
    value: function init() {
      var fragment = document.createDocumentFragment();
      this.domWrapper = document.createElement('div');
      this.domWrapper.style.cssText = 'white-space: nowrap;';
      this.opts.items.forEach(function (item, i) {
        var domSPAN = document.createElement('span');
        domSPAN.style.cssText = 'margin-right: 1.5rem;display: inline-block;vertical-align: middle;';
        domSPAN.innerHTML = '<i style="vertical-align:middle;display:inline-block;">' + item.val + '</i>';
        fragment.appendChild(domSPAN);
      });
      this.domWrapper.appendChild(fragment);
      this.el.appendChild(this.domWrapper);
      this.scrollW = this.el.scrollWidth;
      this.domWrapper.style.width = this.scrollW + 'px';
      if (this.opts.autoplay && this.scrollW > this.el.clientWidth) {
        this.move();
      }
    }
  }, {
    key: 'move',
    value: function move() {
      var _this = this;

      if (this.opts.loop && -this.timerCount === this.scrollW) {
        this.timerCount = this.el.clientWidth;
        this.domWrapper.style.transform = this.domWrapper.style.webkitTransform = 'translate(' + this.el.clientWidth + 'px,0)';
      }
      setTimeout(function () {
        if (_this.timerCount < _this.scrollW) {
          _this.timerCount--;
          _this.domWrapper.style.transform = _this.domWrapper.style.webkitTransform = 'translate(' + _this.timerCount + 'px,0)';
          _this.move();
        }
      }, 1000 / this.opts.speed);
    }
  }], [{
    key: 'mergeOpts',
    value: function mergeOpts(opts) {
      var defaults = {
        direction: 'left',
        speed: 25,
        items: [],
        loop: true,
        autoplay: true
      };
      for (var key in opts) {
        defaults[key] = opts[key];
      }
      return defaults;
    }
  }]);

  return Marquee;
}();

window.Marquee = Marquee;