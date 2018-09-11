{% if page.comments && config.gitTalk %}
    <link rel="stylesheet" href="https://unpkg.com/gitalk/dist/gitalk.css">
    <script src="https://unpkg.com/gitalk/dist/gitalk.min.js"></script>
    <script src="/js/md5.min.js"></script>

    <script>
        var tags = [{% for tag in page.tags %}'{{ tag.name }}', {% endfor %}];

        var gitalk = new Gitalk({
            clientID: '{{ config.gitTalk.clientId }}',
            clientSecret: '{{ config.gitTalk.clientSecret }}',
            repo: '{{ config.gitTalk.repo }}',
            owner: '{{ config.gitTalk.owner }}',
            admin: [{% for item in config.gitTalk.admin %}'{{ item }}', {% endfor %}],
            labels: tags,
            id: (new Date({{ page.date }})).getTime() > (new Date('2018-02-15')).getTime() ? md5(location.href) : location.href
        });

        gitalk.render('comment-container');
    </script>
{% endif %}

{% if page.comments && config.disqus_shortname %}
    <script>
        var disqus_shortname = '{{ config.disqus_shortname }}';
        var disqus_config = function () {
            this.page.url = '{{ config.url }}/{{ page.path }}';
            this.page.identifier = '/{{ page.path }}';
            this.page.title = '{{ page.title }}';
        };

        (function() { // DON'T EDIT BELOW THIS LINE
        var d = document, s = d.createElement('script');
        s.src = 'https://' + disqus_shortname + '.disqus.com/embed.js';
        s.setAttribute('data-timestamp', +new Date());
        (d.head || d.body).appendChild(s);
        })();
    </script>
    <noscript>Please enable JavaScript to view the <a href="https://disqus.com/?ref_noscript">comments powered by Disqus.</a></noscript>
{% endif %}
{% if page.comments && config.valine.enable %}
    <script src="//cdn1.lncld.net/static/js/3.0.4/av-min.js"></script>
    <script src="//unpkg.com/valine/dist/Valine.min.js"></script>
    <script type="text/javascript">
        var GUEST = ['nick','mail','link'];
        var guest = '{{ config.valine.guest_info }}';
        guest = guest.split(',').filter(item=>{
            return GUEST.indexOf(item)>-1;
        });
        new Valine({
            el: '#comment-container' ,
            verify: {{ config.valine.verify }},
            notify: {{ config.valine.notify }},
            appId: '{{ config.valine.appid }}',
            appKey: '{{ config.valine.appkey }}',
            placeholder: '{{ config.valine.placeholder }}',
            avatar:'{{ config.valine.avatar }}',
            guest_info:guest,
            pageSize:'{{ config.valine.pageSize }}' || 10,
        });
    </script>
{% endif %}
