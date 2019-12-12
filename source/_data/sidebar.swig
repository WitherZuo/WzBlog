<style>
    button#xm {
        position: absolute;
        left: 50%;
        margin-left: -80px;
        margin-top: 80px;
        background: #222;
        color: #f5f5f5;
        border: 0;
        width: 160px;
        height: 38px;
    }
</style>
    <button id="xm">ToDarkMode</button>
    <script>
      function toDarkMode() {

        var nightVal = document.querySelector('link[title="dark"]').disabled;

        if (nightVal === true) {
          document.querySelector('link[title="dark"]').disabled = true;
          document.querySelector('link[title="dark"]').disabled = false;
          localStorage.setItem('night', 0);
        } else if (nightVal === false) {
          document.querySelector('link[title="dark"]').disabled = true;
          localStorage.setItem('night', 0);
        }
      }
      var xm = document.getElementById("xm");
      xm.onclick = toDarkMode;
    </script>
