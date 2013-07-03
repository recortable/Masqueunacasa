myMarkItUpSettings = {
    nameSpace:          'markdown', // Useful to prevent multi-instances CSS conflict
    previewParserPath:  '/markitup/preview',
    onShiftEnter:       {keepDefault:false, openWith:'\n\n'},
    markupSet: [
        {name:'Heading 3', openWith:'### ', placeHolder:'Your title here...', className:'markItUpButton3' },
        {name:'Heading 4', openWith:'#### ', placeHolder:'Your title here...', className:'markItUpButton4' },
        {separator:'---------------' },
        {name:'Bold', key:"B", openWith:'**', closeWith:'**', className:'markItUpButton7'},
        {name:'Italic', key:"I", openWith:'_', closeWith:'_', className:'markItUpButton8'},
        {separator:'---------------' },
        {name:'Bulleted List', openWith:'- ', className:'markItUpButton9' },
        {name:'Numeric List', openWith:function(markItUp) {
            return markItUp.line+'. ';
        }, className:'markItUpButton10' },
        {separator:'---------------' },
        {name:'Link', key:"L", openWith:'[', closeWith:']([![Url:!:http://]!])',
          placeHolder:'Your text to link here...', className:'markItUpButton12' },
        {separator:'---------------'},
        {name:'Preview', call:'preview', className:"preview"}
    ]
}
