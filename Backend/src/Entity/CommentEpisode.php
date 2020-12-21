<?php

namespace App\Entity;

use App\Repository\CommentEpisodeRepository;
use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass=CommentEpisodeRepository::class)
 */
class CommentEpisode
{
    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\Column(type="string")
     */
    private $userID;

    /**
     * @ORM\Column(type="integer")
     */
    private $episodeID;

    /**
     * @ORM\Column(type="text")
     */
    private $comment;

    /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $spoilerAlert;

    /**
     * @ORM\Column(type="date", nullable=true)
     */
    private $creationDate;

    /**
     * date constructor.
     */
    public function __construct()
    {
        //$this->creationDate = new \DateTime('Now');
    }
    public function getId(): ?int
    {
        return $this->id;
    }

    /**
     * @return mixed
     */
    public function getUserID()
    {
        return $this->userID;
    }

    /**
     * @param mixed $userID
     */
    public function setUserID($userID): void
    {
        $this->userID = $userID;
    }

    public function getEpisodeID(): ?int
    {
        return $this->episodeID;
    }

    public function setEpisodeID(int $episodeID): self
    {
        $this->episodeID = $episodeID;

        return $this;
    }

    public function getComment(): ?string
    {
        return $this->comment;
    }

    public function setComment(string $comment): self
    {
        $this->comment = $comment;

        return $this;
    }

    public function getSpoilerAlert(): ?bool
    {
        return $this->spoilerAlert;
    }

    public function setSpoilerAlert(?bool $spoilerAlert): self
    {
        $this->spoilerAlert = $spoilerAlert;

        return $this;
    }

    public function getCreationDate(): ?\DateTimeInterface
    {
        return $this->creationDate;
    }

    public function setCreationDate(): self
    {
        $this->creationDate = new \DateTime('Now');

        return $this;
    }
}
