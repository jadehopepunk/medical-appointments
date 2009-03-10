JSTree = Class.create();
Object.extend(JSTree.prototype, {
    initialize: function(tree) {
        this.element = $(tree);
        this.options = Object.extend({
            duration: 0.25,
            collapseAll: false,
            collapsedClass: 'collapsed',
            expandedClass: 'expanded',
            imagePath: '.',
            imageCollapse: 'minus.gif',
            imageExpand: 'plus.gif'
        }, arguments[1] || {});

        this._setup();
    },

    isCollapsed: function(el) {
        el = $(el);
        return el.className == this.options.collapsedClass;
    },

    collapse: function(el, duration) {
        el = $(el);
        if (duration == undefined) duration = this.options.duration;
        var recurse = (arguments[2] == undefined) ? true : arguments[2];

        el.className = this.options.collapsedClass;

        var a = el.firstChild;
        if ((a.nodeType == 1) && (a.className == 'jstreeControl')) {
            a.style.backgroundImage = this._imageUrl(this.options.imageExpand);
        }

        if (recurse) {
            var children = el.getElementsByTagName('li');
            for (var i = 0; i < children.length; i++) {
                var c = children[i];
                this.collapse(c, duration, false);
            }

            var sublists = el.getElementsByTagName('ul')
            for (var j = 0; j < sublists.length; j++) {
                var list = sublists[j];
                Effect.BlindUp(list, { 'duration': duration });
            }

        }
    },

    expand: function(el, duration) {
        el = $(el);
        if (duration == undefined) duration = this.options.duration;

        el.className = this.options.expandedClass;

        var a = el.firstChild;
        if ((a.nodeType == 1) && (a.className == 'jstreeControl')) {
            a.style.backgroundImage = this._imageUrl(this.options.imageCollapse);
        }

        var children = el.childNodes;
        for (i = 0; i < children.length; i++) {
            var child = children[i];
            if ((child.nodeType == 1) && (child.tagName == 'UL')) {
                Effect.BlindDown(child, { 'duration': duration });
            }
        }
    },

    _imageUrl: function(image) {
        var path = this.options.imagePath + '/' + image;
        return 'url("' + path +'")';
    },

    _toggle: function() {
        if (this.treeControl.isCollapsed(this)) {
            this.treeControl.expand(this);
        } else {
            this.treeControl.collapse(this);
        }
    },

    _setup: function() {
        var tree = this.element;
        tree.setAttribute('style', 'list-style: none; ' + tree.style);

        lists = tree.getElementsByTagName('ul');
        for (var i = 0; i < lists.length; i++) {
            var sublist = lists[i];
            sublist.setAttribute('style', 'list-style: none; ' + sublist.style);
        }

        var items = tree.getElementsByTagName('li');
        for (var i = 0; i < items.length; i++) {
            var item = items[i];
            var collapsable = item.getElementsByTagName('ul').length > 0;
            if (collapsable) {
                var collapsed = this.isCollapsed(item);
                var img = this._imageUrl(collapsed ? this.options.imageExpand : this.options.imageCollapse);
                var style = 'padding-left: 15px; background: ' + img + ' left no-repeat;';
                var a = document.createElement('a');
a.innerHTML = '&nbsp;';
                a.setAttribute('style', style);
                a.setAttribute('class', 'jstreeControl');
                a.onclick = this._toggle.bindAsEventListener(item);
                item.insertBefore(a, item.firstChild);
                item.treeControl = this;

                if (collapsed || this.options.collapseAll) {
                    this.collapse(item, 0);
                }
            }
        }
    }
});

Behaviour.register({
    'ul.jstree': function(list) {
        //  new JSTree(list, { 'collapseAll': true, 'duration': 0 });
        //  new JSTree(list, { 'collapseAll': true, 'duration': 3 });
        new JSTree(list, { 'collapseAll': true });
    }
});
