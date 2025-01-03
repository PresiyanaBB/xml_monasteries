function attachListeners() {
    document.getElementById('name-button').addEventListener('click', () => {
        applyTransformation('name', 'text', 'ascending');
    });

    document.getElementById('area-button').addEventListener('click', () => {
        applyTransformation('area-in-sq-meters', 'number', 'descending');
    });

    document.getElementById('properties-button').addEventListener('click', () => {
        applyTransformation('properties-count', 'number', 'descending');
    });

    document.getElementById('guest-rooms-button').addEventListener('click', () => {
        applyTransformation('rooms-for-guests', 'number', 'descending');
    });
}

// Reattach listeners every time the DOM changes, if needed
attachListeners();


function applyTransformation(sortBy, dataType, order) {
    const xhr = new XMLHttpRequest();
    xhr.open('GET', 'monasteries.xslt', true); // Adjust the path if needed
    xhr.onload = () => {
        if (xhr.status === 200) {
            const xsltProcessor = new XSLTProcessor();
            const parser = new DOMParser();
            const xslDoc = parser.parseFromString(xhr.responseText, 'application/xml');
            xsltProcessor.importStylesheet(xslDoc);

            // Add sorting parameters
            const sortParams = {
                'sort-by': sortBy,
                'data-type': dataType,
                'order': order,
            };
            for (const [key, value] of Object.entries(sortParams)) {
                xsltProcessor.setParameter(null, key, value);
            }

            const xmlDoc = document.implementation.createDocument('', '', null);
            const monasteriesContainer = document.getElementById('monasteries-container');

            // Load your XML data here
            const xmlXhr = new XMLHttpRequest();
            xmlXhr.open('GET', 'monasteries.xml', true); // Adjust the path if needed
            xmlXhr.onload = () => {
                if (xmlXhr.status === 200) {
                    const catalogDoc = parser.parseFromString(xmlXhr.responseText, 'application/xml');
                    const resultDocument = xsltProcessor.transformToFragment(catalogDoc, document);
                    monasteriesContainer.innerHTML = '';
                    monasteriesContainer.appendChild(resultDocument);
                }
            };
            xmlXhr.send();
        }
    };
    xhr.send();
}
