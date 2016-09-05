var ideaTemplate = _.template(
  '<div class="idea">' +
    '<h2 class="idea-title"><%= title %></h2>' +
    '<p class="idea-body"><%= body %></p>' +
    '<p class="idea-quality"><%= quality %></p>' +
    '<div class="idea-qualities idea-buttons">' +
      '<button class="idea-promote"></button>' +
      '<button class="idea-demote"></button>' +
      '<button class="idea-delete"></button>' +
    '</div>' +
  '</div>'
);
