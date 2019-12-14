<script type="module" data-no-instant>
    import {Workbox} from 'https://cdn.jsdelivr.net/npm/workbox-cdn@4.3.1/workbox/workbox-window.prod.mjs';
    if ('serviceWorker' in navigator) {
        const wb = new Workbox('/sw.js');
        
        wb.addEventListener('activated', (event) => {
            if (event.isUpdate) {
                appRefresh ({
                    text: '已更新最新版本',
                    action: '点击刷新',
                    callback: () => location.reload()
                })
            }
        });
        wb.register();
    }
    async function appRefresh({text, action, callback}={}) {
        let themeColor = document.querySelector('meta[name=theme-color]');
        let dom = document.createElement('div');
        themeColor && (themeColor.content = '#222');
        dom.innerHTML = `
            <style>
                .app-refresh {
                    background: #222;
                    height: 0;
                    line-height: 3em;
                    overflow: hidden;
                    position: fixed;
                    top: 0;
                    left: 0;
                    right: 0;
                    z-index: 42;
                    padding: 0 1em;
                    transition: all .3s ease;
                }
                .app-refresh-wrap {
                    display: flex;
                    color: #fff;
                }
                .app-refresh-wrap label {
                    flex: 1;
                }
                .app-refresh-show {
                    height: 3em;
                }
            </style>
            <div class="app-refresh" id="app-refresh">
                <div class="app-refresh-wrap" onclick="(${callback})()">
                    <label>${text}</label>
                    <span>${action}</span>
                </div>
            </div>
        `;
        document.body.appendChild(dom);
        setTimeout(function() {
            document.getElementById('app-refresh').className += ' app-refresh-show';
        }, 16);
    }
</script>
<link rel="manifest" href="/manifest.json">
<link rel="apple-touch-icon" href="https://www.wzblog.fun/images/apple-touch-icon-next.png">
<meta name="apple-mobile-web-app-title" content="WzBlog">
<meta name="apple-mobile-web-app-capable" content="yes">
<script defer="defer" src="https://cdn.jsdelivr.net/npm/instant.page@3.0.0/instantpage.min.js" type="module"></script>