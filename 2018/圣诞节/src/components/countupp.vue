<script>
import Countup from 'countup.js'
export default {
  name: 'Countup',
  props: {
    tag: {
      type: String,
      default: 'span'
    },
    start: {
      type: Boolean,
      default: true
    },
    startVal: {
      type: Number,
      default: 0
    },
    endVal: {
      type: Number,
      required: true
    },
    decimals: {
      type: Number,
      default: 0
    },
    duration: {
      type: Number,
      default: 2
    },
    options: {
      type: Object,
      default () {
        return {}
      }
    }
  },
  mounted () {
    console.log(this.options)
    this.$nextTick(() => {
      this._countup = new Countup(this.$el, this.startVal, this.endVal, this.decimals, this.duration, this.options)
      if(!this._countup.error) {
        this.start && this._countup.start(this.countUpComplete)
      } else {
        console.error(this._countup.error)
      }
    })
  },
  render (h) {
    return h(this.tag, {}, [this.startVal])
  },
  watch: {
    start (val) {
      if (val) {
        this._countup.start()
      }
    },
    endVal (val) {
      this._countup.update(val)
    }
  },
  methods: {
    countUpComplete (param) {
      console.log('countUpComplete!')
    }
  }
}
</script>