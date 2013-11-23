or(
  and(
    is(/relation, 'self'),
    auth.has_scope('account.read', auth/scopes)
  ),
  and(
    is(/relation, 'friend'),
    auth.has_scope('friend_account.read', auth/scopes)
  ),
  is('528*2934nasdf#$', test/name, 6.012, true)
)