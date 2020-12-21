<?php

namespace App\Entity;

use App\Repository\FollowRepository;
use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass=FollowRepository::class)
 */
class Follow
{
    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $userID;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $friendID;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getUserID(): ?int
    {
        return $this->userID;
    }

    public function setUserID(int $userID): self
    {
        $this->userID = $userID;

        return $this;
    }

    public function getFriendID(): ?string
    {
        return $this->friendID;
    }

    public function setFriendID(string $friendID): self
    {
        $this->friendID = $friendID;

        return $this;
    }
}
