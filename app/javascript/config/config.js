import List from "@editorjs/list"
import Paragraph from "@editorjs/paragraph"
import AceCodeEditorJS from "ace-code-editorjs";
import "ace-builds/esm-resolver";
import ImageTool from '@editorjs/image';
import Underline from '@editorjs/underline';
import Table from '@editorjs/table';
const Header = require("editorjs-header-with-alignment")
const Alert = require('editorjs-alert');
const Quote = require('@editorjs/quote');
const InlineCode = require('@editorjs/inline-code');

const aceConfig = {
    languages: {
        plain: {
            label: "Plain Text",
            mode: "ace/mode/plain_text",
        },
        html: {
            label: "HTML",
            mode: "ace/mode/html",
        },
        ruby: {
            label: "Ruby",
            mode: "ace/mode/ruby",
        },
        erb: {
            label: "Erb",
            mode: "ace/mode/erb",
        },
        javascript: {
            label: "JavaScript",
            mode: "ace/mode/javascript",
        },
        css: {
            label: "CSS",
            mode: "ace/mode/css",
        },
        php: {
            label: "PHP",
            mode: "ace/mode/php",
        },
        jsx: {
            label: "JSX",
            mode: "ace/mode/jsx",
        },
        tsx: {
            label: "TSX",
            mode: "ace/mode/tsx",
        },
        typescript: {
            label: "TypeScript",
            mode: "ace/mode/typescript",
        },
        sql: {
            label: "SQL",
            mode: "ace/mode/sql",
        },
        python: {
            label: "Python",
            mode: "ace/mode/python",
        },
        rust: {
            label: "Rust",
            mode: "ace/mode/rust",
        },
        go: {
            label: "Go",
            mode: "ace/mode/golang",
        },
    },
    options: {
        fontSize: 18,
        minLines: 1,
        theme: "ace/theme/one_dark",
        hScrollBarAlwaysVisible: false,
        vScrollBarAlwaysVisible: false,
        highlightGutterLine: false,
        printMargin: false
    },
};

export const Tools = {
    header: {
        class: Header,
        inlineToolbar: true,
        levels: [1, 2, 3, 4],
        defaultLevel: 1
    },
    list: {
        class: List,
        inlineToolbar: true,
        config: {
            defaultStyle: 'unordered'
        }
    },
    paragraph: {
        class: Paragraph,
        config: {
            inlineToolbar: true
        }
    },
    image: {
        class: ImageTool,
        config: {
            endpoints: {
                byFile: `/articles/upload_image`
            },
            additionalRequestHeaders: {
                "X-CSRF-Token": csrfToken()
            }
        }
    },
    code: {
        class: AceCodeEditorJS,
        config: aceConfig,
    },
    alert: Alert,
    underline: Underline,
    table: {
        class: Table,
        inlineToolbar: true,
        config: {
            rows: 2,
            cols: 3,
        },
    },
    quote: {
        class: Quote,
        inlineToolbar: true,
        shortcut: 'CMD+SHIFT+O',
        config: {
            quotePlaceholder: 'Enter a quote',
            captionPlaceholder: 'Quote\'s author',
        }
    },
    inlineCode: {
        class: InlineCode,
        shortcut: 'CMD+SHIFT+M',
    }
}

function csrfToken() {
    const metaTag = document.querySelector("meta[name='csrf-token']")
    return metaTag ? metaTag.content : ""
}
