document.getElementById("name-button").addEventListener("click", () => {
  applyTransformation("name", "text", "ascending");
});

document.getElementById("area-button").addEventListener("click", () => {
  applyTransformation("area-in-sq-meters", "number", "descending");
});

document.getElementById("properties-button").addEventListener("click", () => {
  applyTransformation("properties-count", "number", "descending");
});

document.getElementById("guest-rooms-button").addEventListener("click", () => {
  applyTransformation("rooms-for-guests", "number", "descending");
});

function applyTransformation(sortBy, dataType, order) {
  const xhr = new XMLHttpRequest();
  xhr.open("GET", "monasteries.xslt", true);
  xhr.onload = () => {
    if (xhr.status === 200) {
      const xsltProcessor = new XSLTProcessor();
      const parser = new DOMParser();
      const xslDoc = parser.parseFromString(xhr.responseText, "application/xml");
      xsltProcessor.importStylesheet(xslDoc);

      xsltProcessor.setParameter(null, "sort-by", sortBy);
      xsltProcessor.setParameter(null, "data-type", dataType);
      xsltProcessor.setParameter(null, "order", order);

      const xmlXhr = new XMLHttpRequest();
      xmlXhr.open("GET", "monasteries.xml", true);
      xmlXhr.onload = () => {
        if (xmlXhr.status === 200) {
          const xmlDoc = parser.parseFromString(xmlXhr.responseText, "application/xml");
          const resultFragment = xsltProcessor.transformToFragment(xmlDoc, document);

          const monasteriesContainer = document.getElementById("monasteries-container");
          monasteriesContainer.innerHTML = "";
          monasteriesContainer.appendChild(resultFragment);
        }
      };
      xmlXhr.send();
    }
  };
  xhr.send();
}
