'use strict';

var github = require('../_common/github.js');
var owner = 'astral-sh';
var repo = 'uv';

/******************************************************************************/
/** Note: Delete this Comment!                                               **/
/**                                                                          **/
/** Need a an example that filters out miscellaneous release files?          **/
/**   See `deno`, `gitea`, or `caddy`                                        **/
/**                                                                          **/
/******************************************************************************/

// let Releases = module.exports;

// Releases.latest = async function () {
//   let all = await github(null, owner, repo);
//   return all;
// };

// Releases.sample = async function () {
//   let normalize = require('../_webi/normalize.js');
//   let all = await Releases.latest();
//   all = normalize(all);
//   // just select the first 5 for demonstration
//   all.releases = all.releases.slice(0, 5);
//   return all;
// };

// if (module === require.main) {
//   (async function () {
//     let samples = await Releases.sample();

//     console.info(JSON.stringify(samples, null, 2));
//   })();
// }

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
