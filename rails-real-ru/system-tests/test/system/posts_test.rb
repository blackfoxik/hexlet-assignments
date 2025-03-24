# frozen_string_literal: true

require 'application_system_test_case'

# BEGIN
class PostsTest < ApplicationSystemTestCase
  def setup
    @post = posts(:one)
  end

  test 'visiting the index' do
    visit posts_url

    assert_selector 'h1', text: 'Posts'
    Post.all.each do |post|
      assert_selector 'td', text: post.title
      assert_link('Show', href: post_path(post))
      assert_link('Edit', href: edit_post_path(post))
      assert_link('Destroy', href: post_path(post))
    end
    assert_link('New Post', href: new_post_path)
  end

  test 'visiting the show' do
    visit post_url(@post)

    assert_selector 'h1', text: @post.title
    assert_text(@post.body)
    @post.comments.each do |comment|
      assert_text(comment.body)
      assert_text(I18n.l(comment.created_at, format: :short))
      assert_link('Edit', href: edit_post_comment_path(@post, comment))
      assert_link('Delete', href: post_comment_path(@post, comment))
    end
    # save_and_open_screenshot
    assert_field('post_comment_body')
    assert_button('Create Comment', type: 'submit')
    assert_link('Edit', href: edit_post_path(@post))
    assert_link('Back', href: 'javascript:history.back()')
  end

  test 'visiting the new' do
    visit new_post_url

    assert_selector 'h1', text: 'New post'
    # debugger
    assert_field('Title')
    assert_field('Body')

    # save_and_open_screenshot
    assert_button('Create Post', type: 'submit')
    assert_link('Back', href: 'javascript:history.back()')
  end

  test 'visiting the edit' do
    visit edit_post_url(@post)

    assert_selector 'h1', text: 'Editing post'
    assert_field('Title', with: @post.title)
    assert_field('Body', with: @post.body)

    assert_button('Update Post', type: 'submit')
    assert_link('Show', href: post_path(@post))
    assert_link('Back', href: 'javascript:history.back()')
  end

  test 'creating a post' do
    visit new_post_url
    fill_in 'Title', with: @post.title
    fill_in 'Body', with: @post.body

    assert_difference('Post.count') do
      click_button('Create Post')
      assert_selector('.alert.alert-info', text: 'Post was successfully created.')
      post = Post.last
      assert_current_path post_path(post)
      assert_text post.body
      assert_text post.title
    end
  end

  test 'updating a post' do
    visit edit_post_url(@post)
    fill_in 'Title', with: 'New Title'
    fill_in 'Body', with: 'Some Gibberish'

    click_button('Update Post')
    assert_selector('.alert.alert-info', text: 'Post was successfully updated.')
    assert_current_path post_path(@post)
    @post.reload
    assert_equal(@post.title, 'New Title')
    assert_equal(@post.body, 'Some Gibberish')
    assert_text @post.body
    assert_text @post.title
  end

  test 'destroying a post' do
    visit posts_url
    assert_text 'One'

    assert_difference('Post.count', -1) do
      accept_confirm 'Are you sure?' do
        find_link('Destroy', href: post_path(@post)).click
      end
      assert_selector('.alert.alert-info', text: 'Post was successfully destroyed.')
      assert_current_path posts_path
      refute_text 'One'
    end
  end
end
# END
