class ServerSideAdapter
  constructor: ->
    console.log("ServerSideAdapter.constructor")

  loadPosts: =>
    console.log("serverSideAdapter.loadPosts")
    $.ajax(
      type: "GET"
      url: "/posts.json"
      success: (postsJson) =>
        @jsonPostsLoaded(postsJson)
      error: => @jsonPostsNotLoaded
    )

  jsonPostsLoaded: (jsonPosts)=>
    @postsLoaded(jsonPosts.map((jsonPost) => @buildPostFromJson(jsonPost)))

  buildPostFromJson: (jsonPost) =>
    post = new Post(jsonPost.id, jsonPost.name, jsonPost.content)

  postsLoaded: (posts) =>

  deletePost: (post) =>
    $.ajax(
      type: "DELETE"
      url: "/posts/#{post.id}.json"
      success: (json) =>
        @deletePostSucceeded(json)
      error: (json) =>
        @deletePostFailed(json)
    )
    
  deletePostSucceeded: (json) =>
    console.log(json)

  createNewPost: (post) =>
    $.ajax(
      type: "POST"
      url: "/posts.json"
      data: 
        post:
          name: post.name
          content: post.content
      success: (json) =>
        @createPostSucceeded(json, post)
      error: (json) =>
        @createPostFailed(json)
    )

  createPostSucceeded: (json, post) =>
    console.log(json)
    post.id = json.id
    


  createPostFailed: (json) =>
    console.log (json)

  updatePost: (post, name, content) =>
    $.ajax(
      type: "PUT"
      url: "/posts/#{post.id}.json"
      data: 
        post:
          name: name
          content: content
      success: (json) =>
        @updatePostSucceeded(json)
      error: (json) =>
        @updatePostFailed(json)
    )

  updatePostSucceeded: (json) =>
    console.log(json)

  updatePostFailed: (json) =>
    console.log(json)