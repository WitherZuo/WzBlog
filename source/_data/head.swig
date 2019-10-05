<script src="/sw-register.js"></script>
<link rel="manifest" href="/manifest.json">
<link rel="apple-touch-icon" href="/images/apple-touch-icon-next.png">
<meta name="apple-mobile-web-app-title" content="WzBlog">
<meta name="apple-mobile-web-app-capable" content="yes">
<script>
  ;(function () {
    var src = 'https://cdn.bootcss.com/eruda/1.5.6/eruda.min.js';
    if (!/eruda=true/.test(window.location) && localStorage.getItem('active-eruda') != 'true') return;
    document.write('<scr' + 'ipt src="' + src + '"></scr' + 'ipt>');
    document.write('<scr' + 'ipt>eruda.init();</scr' + 'ipt>');
  })();
</script>