<style>
    hr {
        width: 120px;
        margin-left: auto;
        margin-right: auto;
    }

    .description {
        margin: 0 0 10px 0;
        text-align: center;
        font-weight: 700;
    }
    
    #qrcode {
        width: 138px;
        height: 138px;
        margin: 0 auto;
    }

    canvas, img#qrcodeImg {
        width: 128px;
        border: 3px solid #000;
        padding: 2px;
    }
</style>
<hr />
<div class="qrcodeBox">
    <p class="description">本文地址二维码</p>
    <div id="qrcode"></div>
    <img id="qrcodeImg" alt="qrcodeImg" />
    <script src='https://cdn.jsdelivr.net/npm/jquery@3.4.1/dist/jquery.min.js'></script>
    <script src="/js/jquery.qrcode.min.js"></script>
    <script>
        var qrcode = $('#qrcode').qrcode(window.location.href).hide();
        var canvas = $('canvas')[0];
        $('#qrcodeImg').attr('src', canvas.toDataURL('image/png'));
    </script>
</div>