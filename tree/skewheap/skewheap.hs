data SkewHeap a = Empty
                | Node a (SkewHeap a) (SkewHeap a)

singleton :: Ord a => a -> SkewHeap a
singleton x = Node x Empty Empty

union :: Ord a => SkewHeap a -> SkewHeap a -> SkewHeap a
Empty              `union` t2                 = t2
t1                 `union` Empty              = t1
t1@(Node x1 l1 r1) `union` t2@(Node x2 l2 r2)
   | x1 <= x2                                 = Node x1 (t2 `union` r1) l1
   | otherwise                                = Node x2 (t1 `union` r2) l2

insert :: Ord a => a -> SkewHeap a -> SkewHeap a
insert x heap = singleton x `union` heap

extractMin :: Ord a => SkewHeap a -> Maybe (a, SkewHeap a)
extractMin Empty        = Nothing
extractMin (Node x l r) = Just (x, l `union` r)