<template>
  <div class="finder">
    <h1 id="title">{{title}}</h1>
    <input id="file-picker" type="file" accept="image/*" capture="camera" v-on:change="fileProcess"></input>
    <div class="preview-pane">
      <button v-on:click="fileBrowse" class="good">Take a Pic or Select File</button>
    </div>
    <div class="preview-pane" v-if="currImg">
      <img id="preview-image" class="input" :src="currImg"/>
      <button v-on:click="sendReq" class="good">Take me to your litre!</button>
    </div>
    <div class="preview-pane" id="error-pane" v-show="error">
      <div class="input" id="error-preview">
        <h1><i class="fa fa-video-camera" aria-hidden="true"></i><br/></h1>
        Whoops... something is wrong with your camera. :(
      </div>
    </div>
    <div id="output">
      {{output}}
    </div>
  </div>
</template>

<script>
  export default {
    name: 'Finder',
    data () {
      return {
        title: 'Bottlefinder',
        captureStatus: false,
        currImg: null,
        error: false,
        deviceList: '',
        output: ''
      }
    },
    methods: {
      retry: function (e) {
        this.captureStatus = false
      },
      fileBrowse: function (e) {
        var file = document.getElementById('file-picker')
        file.click()
      },
      fileProcess: function (e) {
        // var imgPrev = document.getElementById('preview-image')
        var file = document.getElementById('file-picker')
        var reader = new FileReader()
        var d = this

        reader.addEventListener('loadend', function () {
          d.currImg = reader.result
          d.captureStatus = true
        }, false)

        if (file) {
          reader.readAsDataURL(e.target.files[0])
        }
      },
      sendReq: function (e) {
        var d = this
        if (d.currImg) {
          var endPoint = '/api/analyze'
          var body = {
            image_content: d.currImg.split(',', 2)[1]
          }
          console.log(body)
          d.$http.post(endPoint, body)
            .then(function (response) {
              console.log(response)
            })
        }
      }
    },
    mounted: function () {
    }
  }
</script>

<style scoped>
  @import url('https://fonts.googleapis.com/css?family=Barlow+Condensed|Lobster');
  @import url('https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css');
  canvas {
    display: none
  }
  #title {
    font-size: 3em;
    font-family: 'Lobster', cursive;
  }
  #error-preview {
    background-color: #234;
    margin: 0 auto;
    color: #567;
    display: table-cell;
    vertical-align: middle;
  }
  #file-picker {
    visibility: hidden;
  }
  .input {
    width: 400px;
    height: auto;
  }
  .preview-pane {
    width: 400px;
    margin: 0 auto;
  }
  .finder {
    font-family: 'Barlow Condensed', sans-serif;
    text-align: center;
    color: #eee;
    width: 600px;
    margin: 0 auto;
    padding: 25px 0;
    background-color: rgba(0, 0, 0, 0.8);
  }
  button {
    font-family: 'Barlow Condensed', sans-serif;
    border-radius: 10px;
    width: 250px;
    padding: 10px 20px;
    border: 2px solid black;
    background-color: #a35; 
    color: #eee;
    font-size: large;
    margin: 0.5em auto;
  }
  .good {
    background-color: #35a;
  }
  .meh {
    background-color: #a35;
  }
  @media screen and (max-width: 480px) {
    .finder {
      width: 300px;
      padding: 1em 0;
    }
    .preview-pane {
      width: 300px;
    }
    .input {
      width: 300px;
      height: 300px;
      padding: 0;
    }
  }
</style>
