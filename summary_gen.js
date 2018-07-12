var fs = require("fs")
var path = require("path")
const { promisify } = require('util');

var summary = "# SUMMARY\n";

var ignore = new Set([".git", ".vscode", "style"]);

var directory = path.resolve(".") + '/'

fs.readdirSync(directory).forEach((f) => {
    var filepath = path.resolve(f)
    var stat = fs.statSync(path.resolve(filepath))
    if (stat.isDirectory() && !ignore.has(f)) {
        var titleFile = filepath + '/DEFAULT.md'
        var title
        if (fs.existsSync(titleFile)) {
            var content = fs.readFileSync(titleFile, 'utf8')
            var matched = content.match(/^#\s?(.*)/m)
            if (matched) {
                title = matched[1]
            }
        }

        if (!title) {
            title = f
        }
        summary += "\n## " + title + '\n\n';

        genSection(f + '/', "")
    }
})

function genSection(parent, depth) {
    var files = fs.readdirSync(path.resolve(parent))
    var directories = [];
    var markdowns = [];
    files.forEach(f => {
        var stats = fs.statSync(path.resolve(parent + f))
        if (stats.isDirectory()) {
            directories.push(f)
        } else if (f.endsWith(".md") && f != 'DEFAULT.md') {
            markdowns.push(f)
        }
    });
    directories.forEach(d => {
        var filepath = directory + parent + d;
        var defaultFile = filepath + '/DEFAULT.md'
        var title
        var link
        if (fs.existsSync(defaultFile)) {
            var content = fs.readFileSync(defaultFile, 'utf8')
            var matched = content.match(/^#\s?(.*)/m)
            if (matched) {
                title = matched[1]
            }
            link =  parent + d + '/DEFAULT.md'
        }
        if (!title) {
            title = d
        }
        if (link) {
            summary += depth + "* [" + title + '](' + link + ')\n';
        } else {
            summary += depth + "* " + title + '\n';
        }

        genSection(parent + d + '/', depth + "    ")
    })
    markdowns.forEach(md => {
        var filepath = directory + parent + md;
        var title
        if (fs.existsSync(filepath)) {
            var content = fs.readFileSync(filepath, 'utf8')
            var matched = content.match(/^#\s?(.*)/m)
            if (matched) {
                title = matched[1]
            }
            if (!title) {
                title = md
            }
            summary += depth + "* [" + title + '](' + (parent + md) + ')\n';
        }
    })
}


fs.writeFileSync(path.resolve("SUMMARY.md"), summary)


//console.info(summary);