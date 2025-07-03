'use strict';

var github = require('../_common/github.js');
var owner = 'astral-sh';
var repo = 'uv';

module.exports = function () {
  return github(null, owner, repo).then(function (all) {
    all.releases = all.releases.filter(function (rel) {
      return !/(\.sh$)|(\.ps1$)|(\.sum$)|(\.json$)|(source.*$)/.test(rel.name);
    });
    return all;
  });
};

if (module === require.main) {
  module.exports().then(function (all) {
    all = require('../_webi/normalize.js')(all);
    // just select the first 5 for demonstration
    // all.releases = all.releases.slice(0, 5);
    console.info(JSON.stringify(all, null, 2));
  });
}
